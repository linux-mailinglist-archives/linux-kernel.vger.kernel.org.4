Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267735F335B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJCQU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJCQUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:20:50 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F291CB3E;
        Mon,  3 Oct 2022 09:20:46 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1324e7a1284so4865875fac.10;
        Mon, 03 Oct 2022 09:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SrQIQIx2drceX3SN+9GboVD+7L3gb+zcudmTPkuxG4o=;
        b=74PA7FsdMI96xzv9bqMWG/1z88UVSaX9POETSMo4bJBNWkOElBK8jZZ77mjDsBZm8Z
         Ga8ah6PnAyBnDe1pPW0cDzALv9lUfDZpZd5BugKnURxt9mYFZ3Nla05POwd14UDmQb6U
         cNhNTkDX7EWfsfGGesctXNsT/PKmMNe3hFLRG2QiHnbLWSCaulQQdbTmmhAV0ad5Y1Yx
         YdEvp9/sGqNGpqnufXJRZwdGGWU8bwk1mrL9yqg3grty+g94uOfyzzZF0duO0Oo+TBeL
         5+aO8EI2BUW/C9z+AIv3TgowOlffIlsK/6QF4Bf9T4Jnll1/70PDQF5oCW4Xi0zwcTfM
         Nc5g==
X-Gm-Message-State: ACrzQf2Q005qtIGy919ih/4gpbc8sUaOueuWq1QsOiRh0sinJQgOippD
        u4XeRaDFQsPW1O5/aYqoDQ==
X-Google-Smtp-Source: AMsMyM6cKgji6ciyhbfcp4feIvszGehOxAdPhv6e9KCbMI8b2WBWiPgQvBwA1TqrxbMdcC2DrtjgNg==
X-Received: by 2002:a05:6870:f60e:b0:131:b7cc:f994 with SMTP id ek14-20020a056870f60e00b00131b7ccf994mr5798922oab.113.1664814046016;
        Mon, 03 Oct 2022 09:20:46 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u17-20020a4ac991000000b00435a8024bc1sm2146879ooq.4.2022.10.03.09.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:20:45 -0700 (PDT)
Received: (nullmailer pid 2402827 invoked by uid 1000);
        Mon, 03 Oct 2022 16:20:44 -0000
Date:   Mon, 3 Oct 2022 11:20:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        tiwai@suse.com, devicetree@vger.kernel.org,
        shengjiu.wang@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linuxppc-dev@lists.ozlabs.org, perex@perex.cz, lgirdwood@gmail.com
Subject: Re: [PATCH v3 1/7] ASoC: dt-bindings: fsl_rpmsg: Add a property to
 assign the rpmsg channel
Message-ID: <166481404372.2402771.4568296878254068845.robh@kernel.org>
References: <20220930064441.2548505-1-chancel.liu@nxp.com>
 <20220930064441.2548505-2-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930064441.2548505-2-chancel.liu@nxp.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 14:44:35 +0800, Chancel Liu wrote:
> Add a string property to assign the rpmsg channel this sound card sits
> on. This property can be omitted if there is only one sound card and it
> sits on "rpmsg-audio-channel".
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 36 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
