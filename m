Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6656CC314
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjC1OvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjC1Oup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:50:45 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12714E385;
        Tue, 28 Mar 2023 07:50:19 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i6so15394315ybu.8;
        Tue, 28 Mar 2023 07:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680015019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiDQyAXhgWCz4KK2SHpIkYv9FCWP7ln2+V7AJtildZ4=;
        b=oAx3D/IZESQgWeH5/u7nYGbo3gkv70eejPKpr225Vmm66knBU37kofn38W0AKNTGn+
         x/4pe7fBnIOnazHzKhbu6Ov5SemHVPLZ5WRkKoPINymk8S2yHH5bV1lkGMp9/e8wm+9e
         Y3KBOmQqODrOdVZqBIOHqzn1IBWbj8UW4B5FlSG8rnPhp8q57ROI3jH3S+3tFs2ypn/V
         RxNJlGeedBXxyUI2yigo/mGPdA42ft2WLnjpKusmgIbJTrSW+6vkaNEmum49ezotR90m
         IMZJkGXyS/+7+9E29GIYE1FWPLIrp9vpUPTLsa96ngE8zi6nTtfJ8ypIXrwsPvk0Fxfi
         jibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiDQyAXhgWCz4KK2SHpIkYv9FCWP7ln2+V7AJtildZ4=;
        b=OW9Wzr4RoiVWOBqsnWu8q75px0DHS20FGkT6iQGHyrCJ0v+00VVUNBKHveVV7cXtAE
         4UTx3PO1ym8grzs/sWcKxWNz9+/cp2QOnJ3+zvS/nrMcGmZFLTXakdZncy/4m0EQc8Zo
         fToyWTjwnuYnuo0xK0GsnGW/r72XEKxgeqk8+DFvBdC0vQxzwkN6+t3U40yOIEXI5Ji6
         c7/oskmzfkbyO49PYZXQ3zo4okBcjuLSc/KcRib2LhSAyId+nL9Lfqq6n4fHZ6DH1Qh1
         8JU1yBnMWa146/4cavkvstAJ03DhX2HEQDWWRlggLcRl9db+LOXurJb7grhLbFk1XhnS
         vGuA==
X-Gm-Message-State: AAQBX9dWR4bJ8UtwDPGBko3SYf82S8W/s9e7aCq49zS/eCkXIjRA4up0
        me6frmt8EnHimOurys1aZUU=
X-Google-Smtp-Source: AKy350ZIHS0JDgLGX9+NMLarjPoffiIgQyFp/HsmWdcvG5BWLOJWQI7cUPnqyiUWvUooG8byHw3i+w==
X-Received: by 2002:a25:468a:0:b0:b3d:5a52:5c6b with SMTP id t132-20020a25468a000000b00b3d5a525c6bmr18947517yba.21.1680015018888;
        Tue, 28 Mar 2023 07:50:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o137-20020a25418f000000b00b7767ca7496sm2938471yba.51.2023.03.28.07.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:50:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Mar 2023 07:50:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, wim@linux-watchdog.org,
        agross@kernel.org, andersson@kernel.org,
        saiprakash.ranjan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: watchdog: Document Qualcomm SM6115
 watchdog
Message-ID: <501ab5b8-568f-43d4-8121-b888cc49cb50@roeck-us.net>
References: <20230314051351.1754321-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314051351.1754321-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:43:51AM +0530, Bhupesh Sharma wrote:
> Add devicetree binding for watchdog present on Qualcomm
> SM6115 SoC.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter
