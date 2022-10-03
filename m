Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338AA5F34AA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJCRi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJCRhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:37:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5F5EA2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:37:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w10so2705967edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ijFN0pckMxMj1+3wCxL1Fk38QuW7ODIv6czvGYPmiDw=;
        b=sJqIrooGQ/qLu5yTUeUgcIsVc14jPuOsV0OKUcmVRacbYyxIBu2XF8HLpNbDQXuU68
         FWVaL0oHcJoGJg03MfD3V4SoIheIQ2N1+w7q5x9InZPsAmiO+cNrcUW6u6kEaxVZiceH
         dAdLV5XdjfoT5GREPCzQx01GKCfxNQiSxu20KGkFjXrQVt9NfNa/7gvYgFkssVmhRakw
         VbNsl8q8ffbRdcQUrfXVClm1hRbXXxss5Ohczg9Cvo5NQiAFIvOAlc9uXhVikTHtUvLQ
         bGrFCumdEK0nksxZGCK86od7+9FxISNFTlaI/ZN8sVOASRMExMY8LTswk3dCJGufAGiR
         x+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ijFN0pckMxMj1+3wCxL1Fk38QuW7ODIv6czvGYPmiDw=;
        b=OQlWHTgcJvaVJIICdPOdneDQO2Gg6fOYv2UNUHq+/5PApNMV/W/kqefFU9EMyKVBXe
         lJUGXycwPehfe1VWLur/29AuvRpg/VVIFUcfw0tbyep67LpBPFgRMLls0mVXBQSJH1TI
         T9YYVoSjljKpyQSVG5Ty0XfEnMu3hPQ0NPndsa/yc4zfQyP127ENsfT+HvNaJl+JKKrz
         a91A+3W8+ok2n4FjeQBFxFlfm2gziTmyhns9Y8OzBfs6fvFnoE9tIP0ms0tw/DXYjwB6
         8TB/FO1mveV6/2ZMnlVjWLH+pbls8NCoBBGCHeDEcp5iBJ3dCuegU14eqg0iErOOJy/D
         4qKw==
X-Gm-Message-State: ACrzQf2WeCfQvwOhSoT6/aNmKoJhJuT69EGPkpmYOE/eyrg0TpBAjaGL
        Os+wVhumhyWGrWchg137TiMOPl+3YtJbLoLP4bp1Yw==
X-Google-Smtp-Source: AMsMyM7uV2LC47ucZYAkhghPD5jv0D7R8fSPqJuy+W0I0ktRQ8MOwqssCZgV4a9AI56+Ihtn47Mqf7auGrP2BYPGS/k=
X-Received: by 2002:a05:6402:1c19:b0:458:c83b:6253 with SMTP id
 ck25-20020a0564021c1900b00458c83b6253mr8999295edb.313.1664818653798; Mon, 03
 Oct 2022 10:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221001064643.667075-1-davidgow@google.com>
In-Reply-To: <20221001064643.667075-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 3 Oct 2022 10:37:22 -0700
Message-ID: <CAGS_qxrpjrSA7VF=dOavkq34tjH72P2dZ84BG2No5U7rNXBHCQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Update description of --alltests option
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Jonathan Corbet <corbet@lwn.net>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 11:46 PM David Gow <davidgow@google.com> wrote:
>
> kunit_tool's --alltests option was changed in commit
> 980ac3ad0512 ("kunit: tool: rename all_test_uml.config, use it for --alltests")
> to use a manually curated list of architecture-indpendent Kconfig
> options, rather than attempting to use make allyesconfig on UML, which
> was broken.
>
> Update the kunit_tool documentation to reflect the new behaviour of
> --alltests.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks!
