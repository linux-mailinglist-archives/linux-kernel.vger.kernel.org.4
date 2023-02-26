Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789826A3348
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBZRlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBZRlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:41:35 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554B118B27;
        Sun, 26 Feb 2023 09:41:34 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id r5so4502536qtp.4;
        Sun, 26 Feb 2023 09:41:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oidyFnhcS7SwDqjuHZ47EAjwcEKM/kzqjGY4pjnCZ0=;
        b=r0ixf/zKDI6OHRaQVktkCXao96+uis31hIA0DmgNSrnoFUx6DCBbnj/A+dDFL8UDOb
         /nqvpBxmwMlJvs1z8N0cjmOZmIYdSmbwDTGdDzyt1elgySJlPcYJtUBZg3hrczP7nh5y
         cZs3nDqwlLs3FJ1/fU78tw2t/oUbM08kxKB3OXJ5lHFpE3dopH4eDyetYIb/aRZ07nsY
         VC8MNrh/kwoEBxfHkgFFx6L8yQXKju/UGrX/ot32XFssioux6+8DVeTCaV9XJxKcKhGi
         K087uWgzjCWucKSG2mDwi2NMPFz6r4QRCYAdki3xLGvmfnF3S7KdqgRj+wbpfGi7izvJ
         rpQA==
X-Gm-Message-State: AO0yUKWRKhdfI7NiFvp0/KdM7oAPVRYFu+sy6yHx1244vtojSP7ey34H
        FPPWWgpEvuA94mK3oW1J8Q==
X-Google-Smtp-Source: AK7set/p6zXHndIgy3naW4KsapFBmsx01fo+3V13vxRFXmMQ7ZNQx7kg0PJq2R0pDPuK8sjHMvLOEA==
X-Received: by 2002:ac8:5f47:0:b0:3b8:6b57:499e with SMTP id y7-20020ac85f47000000b003b86b57499emr26477536qta.36.1677433293336;
        Sun, 26 Feb 2023 09:41:33 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:8ddf:ff6b:c94c:94fd:4442])
        by smtp.gmail.com with ESMTPSA id e16-20020ac84150000000b003bfa932525dsm3229206qtm.51.2023.02.26.09.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 09:41:33 -0800 (PST)
Received: (nullmailer pid 74900 invoked by uid 1000);
        Sun, 26 Feb 2023 17:41:29 -0000
Date:   Sun, 26 Feb 2023 11:41:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        devicetree@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add Lenovo NT36523W BOE
 panel
Message-ID: <167743328941.74844.4868858650095166172.robh@kernel.org>
References: <20230217-topic-lenovo-panel-v1-0-9d7ee1602089@linaro.org>
 <20230217-topic-lenovo-panel-v1-1-9d7ee1602089@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217-topic-lenovo-panel-v1-1-9d7ee1602089@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Feb 2023 12:29:07 +0100, Konrad Dybcio wrote:
> Add bindings for the 2000x1200px IPS panel found on Lenovo Tab P11/
> XiaoXin Pad devices.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../display/panel/lenovo,nt36523w-boe-j606.yaml    | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

