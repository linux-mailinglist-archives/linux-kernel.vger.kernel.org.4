Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016796B3A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCJJca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjCJJbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:31:50 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94AED7C2A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:29:23 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l1so4391262wry.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678440560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlUmQdynEDDUy3XFMHBGRZdv5WkYIHR+kJeUOIiQplU=;
        b=cgGOgq8CYAlQPbMmdDwACtEPQ7pENf0DEWujsvFWZRFFjTJO2lVx76cYvDWFkdzr2B
         49a3sZSre7oL6SZEjYn1J/VN7F9QGjY1IS93sluhMEs676+0E2Q3vxUAAIyhn1/gFbVf
         bqzmdpKB3m6ztZ62RyKZ1uzuagUijd1qlAAzC8KOF0f7qPS9LaTbccmE0BBDLMZ9B2Eg
         onX3gRM0m+LX0+vCcR/ORxTnJhH8nKUk3wZtbLMS33PJarlt/UX9iguHqW0Yp8J/4za0
         W8+ma1ndFk6xSTPs0sv8x/1DWVRN87ad1Wb/IQpkQeGRxqIir08PKJLWhCQhiu+YKU8Q
         uJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678440560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlUmQdynEDDUy3XFMHBGRZdv5WkYIHR+kJeUOIiQplU=;
        b=IMiilvJWuFH0HlRZCN3/VskZyR4myBEaDj8i62qb+IGOLyNRtojP4Do7N2Jc1BiLPs
         CMAVGqE+CXSt0nUCn2OEgYghzWc5Gcnh+Kw8JETgN8MDLAlszpc3lCzjVTRhXcpVraSZ
         1Zm2JGW9Ycu3oPB2X/YEGxHtlbmnYO3ti6JujW3RdIlj0eskzCIBlJrjj690oV5TGHnU
         cD05aT/D+lYo4prfM6jXDKudJbkZrLhdE1CvJY61pZX+xQe6qhc1yJr+oVXI9YQ7Lwpp
         IPlulayLecSonAVfjwM/UIRBhlXlzD9zud7jE/ww9nVlJiUyOI+pSwmue0aNylZEQhWg
         QVdg==
X-Gm-Message-State: AO0yUKU5ruGwGCSM0q2NU8VSyzeHCpfbwNPrtAPR/qxqCgmAi6tMdc4Q
        ysJzd4fDbOfOhc37GPqLAeekbw==
X-Google-Smtp-Source: AK7set9UfIn2ioxvZ1tkR9i4TGq5CpQtDQZjJA0xwOH8loj2I1wqWMJKLkQmTzDQwkIgH+u0qVpANA==
X-Received: by 2002:a5d:4809:0:b0:2ca:428f:76d0 with SMTP id l9-20020a5d4809000000b002ca428f76d0mr15103621wrq.13.1678440559905;
        Fri, 10 Mar 2023 01:29:19 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id g9-20020a5d4889000000b002c5691f13eesm1652807wrq.50.2023.03.10.01.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:29:19 -0800 (PST)
Message-ID: <9d8ef6df-c0b4-f578-26c3-b186d43c9660@linaro.org>
Date:   Fri, 10 Mar 2023 09:29:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3] dt-bindings: nvmem: convert base example to use
 "nvmem-layout" node
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230310075145.3996-1-zajec5@gmail.com>
 <20230310075145.3996-2-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230310075145.3996-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2023 07:51, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> With support for "fixed-layout" binding we can use now "nvmem-layout"
> even for fixed NVMEM cells. Use that in the base example as it should be
> preferred over placing cells directly in the device node.
> 
Fixed layouts are the core part of nvmem, am not sure why you want to 
deprecate this. Either we derive the cell information dt or via layouts 
or some post processing they should still endup as fixed layouts.
this way the core part is always same irrespective of where the cell 
info comes from.


--srini

> New and other bindings should follow as old binding will get deprecated
> at some point.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   .../devicetree/bindings/nvmem/nvmem.yaml      | 42 +++++++++++--------
>   1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index 732162e9d13e..c77be1c20e47 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -67,24 +67,30 @@ examples:
>   
>             /* ... */
>   
> -          /* Data cells */
> -          tsens_calibration: calib@404 {
> -              reg = <0x404 0x10>;
> -          };
> -
> -          tsens_calibration_bckp: calib_bckp@504 {
> -              reg = <0x504 0x11>;
> -              bits = <6 128>;
> -          };
> -
> -          pvs_version: pvs-version@6 {
> -              reg = <0x6 0x2>;
> -              bits = <7 2>;
> -          };
> -
> -          speed_bin: speed-bin@c{
> -              reg = <0xc 0x1>;
> -              bits = <2 3>;
> +          nvmem-layout {
> +              compatible = "fixed-layout";
> +              #address-cells = <1>;
> +              #size-cells = <1>;
> +
> +              /* Data cells */
> +              tsens_calibration: calib@404 {
> +                  reg = <0x404 0x10>;
> +              };
> +
> +              tsens_calibration_bckp: calib_bckp@504 {
> +                  reg = <0x504 0x11>;
> +                  bits = <6 128>;
> +              };
> +
> +              pvs_version: pvs-version@6 {
> +                  reg = <0x6 0x2>;
> +                  bits = <7 2>;
> +              };
> +
> +              speed_bin: speed-bin@c{
> +                  reg = <0xc 0x1>;
> +                  bits = <2 3>;
> +              };
>             };
>         };
>   
