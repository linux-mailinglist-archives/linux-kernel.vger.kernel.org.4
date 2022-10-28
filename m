Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D517261179D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJ1Qge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiJ1QgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:36:22 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97001CCCCA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:36:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 130so5212661pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fiP/gtk1BinFFJgTXUZEj1NdMWlthKZ0OUfBLn7rLIU=;
        b=nimtRxz4mCnrDpP+awp+tQ1a53a8hyPg7iNtWXfhDq3ltrOL5UCs75i4rozXJGbMPX
         SDVQCO8PRkleubIaQin2/IPNBC4hc/yjrIa8pVbxkiahBacQ89eO+azcDW644Ub8H9WK
         rSEWZcGkj/DmpWCp2i1iWe6DBzQ+UBvL4XPl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiP/gtk1BinFFJgTXUZEj1NdMWlthKZ0OUfBLn7rLIU=;
        b=RG+irE231AySc8mi/JAw97eYchH7S56SnktD8tjfJKosFP8+0JO67N/B4062dV4irR
         zpFL+SEYrGDlBVXZFNUVtkjAfG+ivx7wnnqZbMZR6HDaoFf6cYsgbt/1baX/atvvVPKc
         GdoWj9WHdPj1eECB/tiPffk0kYYD4y4ym6ej1m/U/9xfrVHFpDufUOUiQpNA4vYxLeL9
         MEf/paKddVXR1HBRqEgjKx29mmttcl4QxukWKnytWuvQ4wgTfcsGx6TFYEOvnlzUddGk
         XaYXp7c3xVljHY09AZUzYTszYrhQaPhv02JWRoWi47L2Reyyv+B+vIRwsHqbavK5uicY
         lZWw==
X-Gm-Message-State: ACrzQf3BZoVD4jjJR/bvFK2tl0yr6YnuL7xeBRXbL3Yq9ZAXOOqh8Ium
        xHAO7e1krnUY1Jzq/5x4kX4TXQ==
X-Google-Smtp-Source: AMsMyM4EYfEXFnyMkOYnJEcYhC2e5fufT2TqnDENGZXbTy1gPAt1ADSI1/a/kujO8yVT2unTkINrkA==
X-Received: by 2002:a63:5a05:0:b0:434:23a5:a5ca with SMTP id o5-20020a635a05000000b0043423a5a5camr296969pgb.515.1666974981269;
        Fri, 28 Oct 2022 09:36:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902ca8900b00180a7ff78ccsm3223888pld.126.2022.10.28.09.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:36:20 -0700 (PDT)
Date:   Fri, 28 Oct 2022 09:36:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Grigory Vasilyev <h0tc0d3@gmail.com>,
        Claudio Suarez <cssk@net-c.es>,
        Slark Xiao <slark_xiao@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [next] drm/amdgpu: Replace one-element array with
 flexible-array member
Message-ID: <202210280855.9DF8E4D72@keescook>
References: <Y1tkWdwPUp+UdpM0@mail.google.com>
 <04e37ee1-53b0-97ab-d6d7-a39edfbdc2ea@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04e37ee1-53b0-97ab-d6d7-a39edfbdc2ea@amd.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:18:39AM +0200, Christian König wrote:
> Am 28.10.22 um 07:10 schrieb Paulo Miguel Almeida:
> > One-element arrays are deprecated, and we are replacing them with
> > flexible array members instead. So, replace one-element array with
> > flexible-array member in struct _ATOM_FAKE_EDID_PATCH_RECORD and
> > refactor the rest of the code accordingly.
> > 
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> > 
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://github.com/KSPP/linux/issues/238
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> 
> I'm not sure if that's a good idea. We had multiple attempts to refactor
> this now and it always caused a regression.
> 
> Additional to that the header in question came from our BIOS team and isn't
> following Linux styles in general.
> 
> Alex what do you think?

Fake flexible arrays (i.e. 1-element arrays) are deprecated in Linux[1]
(and, frankly, deprecated in C since 1999 and even well before then given
the 0-sized extension that was added in GCC), so we can't continue to
bring them into kernel sources. Their use breaks both compile-time and
run-time bounds checking efforts, etc.

All that said, converting away from them can be tricky, and I think such
conversions need to explicitly show how they were checked for binary
differences[2].

Paulo, can you please check for deltas and report your findings in the
commit log? Note that add struct_size() use in the same patch may result
in binary differences, so for more complex cases, you may want to split
the 1-element conversion from the struct_size() conversions.

-Kees

[1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
[2] https://outflux.net/blog/archives/2022/06/24/finding-binary-differences/

-- 
Kees Cook
