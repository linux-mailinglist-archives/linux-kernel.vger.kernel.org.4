Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC875B5669
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiILIhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiILIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:37:13 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E59C37180
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:36:31 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1279948d93dso21426663fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=r/2StSj+EsasBdd1v2y2mKFKf96fLWppGryBy74q0RU=;
        b=XQYtsHRdvolJForB/3cj6W0FpJv3aRcTMSAtZh+3Jg2rrqgubmbvy16NXmYj+CQ41U
         uQpFs84hMm54x4s6woJOTh8Wiwxfh/mvczy7HWk6XEiiPLIKVbw6Tira+eZrgnI3StSl
         RQOaokfc54LpMB6TDIS9NYe4FgAijgEO1IXjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=r/2StSj+EsasBdd1v2y2mKFKf96fLWppGryBy74q0RU=;
        b=My16XAUPb1SbTfYfHE+21eIhp+nj5DSvowDprMCzPCZo5MaT6dq9JXs3ZPxH1JK8NI
         /kAuPX5bJh4Xg9wH3hJWqjTKPYALCsf0Z2YACEpvDPxis9QzQ5o1vO0NnL/xzr7LNQiq
         rUiJsbpM7kXFljegMmzUn8SAPhCk9v5xeL2GzphBnhkSspbxRDtAF0Iv5wLO7M7Cxouj
         6sMEYsdRmkyFHzTMwIEjDCsDtkSyDsvYZKrYrvf2qKhfr/sjDz1f0ldWmClO/hmxuHAL
         CAfoKZbLOkRA3Eo9mpG3w3doq4XcyftEgJ23T5rTXwjwLpY675CVb+tj23Prg0iJORjN
         ZqdA==
X-Gm-Message-State: ACgBeo1TOCuU/2po7MOVELwA+9YNXbGi/kPYa5Z5m7l9y9I+xwfq2+UY
        VjB2J9fY6xM+MZOiM4L4tDyepQQHBIBjoQUWvE0go8b5yZbARg==
X-Google-Smtp-Source: AA6agR44XZVPj4+tG+EnN6h6H4+b2opLdLYGAOir8ImE+eDWx4IQlyYPVOOxTaJz0D2+Gx7FMQWozsplmlqFQxiwmcM=
X-Received: by 2002:a05:6808:1997:b0:34f:d372:b790 with SMTP id
 bj23-20020a056808199700b0034fd372b790mr92732oib.2.1662971790185; Mon, 12 Sep
 2022 01:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220912072854.760824-1-yunjunlee@chromium.org> <87r10hhw5w.wl-tiwai@suse.de>
In-Reply-To: <87r10hhw5w.wl-tiwai@suse.de>
From:   YJ Lee <yunjunlee@chromium.org>
Date:   Mon, 12 Sep 2022 16:36:18 +0800
Message-ID: <CAPm_npZeQswPTY2pc9nb1FrNDoqZWGpMwwLN3T2JkEmcgp7YtQ@mail.gmail.com>
Subject: Re: [PATCH v1] ALSA: dummy: Fix trailing whitespaces.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        yuhsuan@chromium.org, whalechang@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 3:46 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 12 Sep 2022 09:28:54 +0200,
> YJ Lee wrote:
> >
> > Fix checkpatch.pl ERROR: trailing whitespaces.
> >
> > Signed-off-by: YJ Lee <yunjunlee@chromium.org>
>
> Thanks, applied now.
>
>
> Takashi

Thanks for your quick response. You're very welcome!

YJ
