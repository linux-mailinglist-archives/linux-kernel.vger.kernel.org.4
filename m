Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB067DA3D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjA0AKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjA0AK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:10:28 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DD860CAD;
        Thu, 26 Jan 2023 16:10:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z11so3416074ede.1;
        Thu, 26 Jan 2023 16:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TzvyztqTUqhDZSZhosPdZdeM50hG8/cWxMKn7fUj6B0=;
        b=RNamU9mUtzrlzn0TAxG1wWURwfki+wfpEmXMkSvbNALsjZyqasLqkhedKzqwa6GLRS
         Iosrt+QBB5N3h9Uxusd4tLHxvmcyxLMUKWNsqyLGPx6xcdYpRPGid2t9gYl2pA7DSMt4
         kCr879ArC5xBiopSrp2kZUK2g9VlMv/BIUFhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzvyztqTUqhDZSZhosPdZdeM50hG8/cWxMKn7fUj6B0=;
        b=qSfLaDoLI9djHYn4u/W46N5Fjy9L5oEeqwBAKww7ETMlJdvst5XhJT1K2s75rx2H/Q
         3XS+PEX3SScZYyjsJpNMIdMtvuNlhY5naclr9NIsPvIj98lhhk7MY98+ZN31dJJEoFep
         kaZhaGpYxa0dvM638bVGSFt/X75gCWX1D+cCdcPEibwjMzhw6Qm28bmPXpHpPBOgJ84e
         5KRZV2z9MiBbenm0RID6Qzap4j2ZxA6fBi4P85w7D3So3nHEvYmQ/lUsSBEaAobykgm5
         CAAhZH/gEMVrcIr0feGBq0OnEx8fVGTXotGJplvur70OHMhNtLeH1oMfbxwO2njKWKQK
         6OBQ==
X-Gm-Message-State: AFqh2kq3Vt0jCl9ZehcrHUYI06gtOzzfeyeqbDWlxDZmlf1s5iDTeg8A
        Kg3kDnq5ARQGoLWh9mns3Ga608CSWCA+J0Rduol2vblg
X-Google-Smtp-Source: AMrXdXsAGTfzRbtQDCKmtyYLn+0y5JFjnEbtEM300Gv9/UP8Xof/oEFHKVTbcRjK5TJLcCg8I5kKsoDJ7mo4T2bhAz0=
X-Received: by 2002:a05:6402:5288:b0:49e:66b8:a790 with SMTP id
 en8-20020a056402528800b0049e66b8a790mr5507160edb.47.1674778223761; Thu, 26
 Jan 2023 16:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20230127110428.34c159b4@canb.auug.org.au>
In-Reply-To: <20230127110428.34c159b4@canb.auug.org.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 27 Jan 2023 00:10:11 +0000
Message-ID: <CACPK8XeNk7dmWjw4N8KxDt5ObR6b=p5wSDRjcpt4cVvbww2X2g@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the aspeed tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 at 00:04, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> The following commit is also in the arm-soc-fixes tree as a different
> commit (but the same patch):
>
>   fc8529f0609d ("ARM: dts: aspeed: Fix pca9849 compatible")
>
> This is commit
>
>   d9b6c322fd33 ("ARM: dts: aspeed: Fix pca9849 compatible")
>
> in the arm-soc-fixes tree.

Thanks, I'll drop this from the aspeed tree now that it's been merged as a fix.

Cheers,

Joel
