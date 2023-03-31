Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221B26D1906
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCaHvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjCaHvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:51:14 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BE61A96B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:50:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id by14so2966450ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680249010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rp61AZrrrJ7L6Ea4XSRLHJ/Ln9sIYk2x6qqY8rh7zM4=;
        b=qM+oBIBD6/4I26sY9lrDp/o6uOQD+VJqjveehx5YKQ5U4XVIIJdQyWfIqLGrjSRFGM
         OVSGuWvmjg4bHjNyx4hooahb8ZMXIF/FKcH4A5/DTX/UO0KoQpdLzBt1duQeuwiyQlIr
         NegaXc/uhq0C1G8dE3Fpmy8fAcmOIGLaYTrPkO3pkKx0T4Hi4XcEedrpVbXhpqhG7rQ3
         S0+dsfpQTRhlfRl1DUePVmMgOpbBV8Ti9hlTG8cxeRVgJUvjsTDqVIWBJDPXYasUVgeO
         4y13tVzzYjdCDj469LKssnOgESUixPCxtuHXtIPKnoFh1PDNs+6opz42G4RdfEUCKu+V
         f2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680249010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rp61AZrrrJ7L6Ea4XSRLHJ/Ln9sIYk2x6qqY8rh7zM4=;
        b=L7oAZAwptkX0TJLIGzZTBAdcPOpt+TMPYnbixsJhtRxCjXpz6CiGST49lWJFoXF4Zi
         XLTkmO9e72abTf6G2qu6eunpzAoHvycRI8C5m0Xi4+htQge0cqI9LJ+sR4hcVpsOJ77E
         PVyY5BWwWaZpMxkaJw0kD+395VOjiZ7WOSS1VsdYItDjO9SOibtUS5F+zCm5xLg9pOs3
         8c/glDIvs3GNc9lbygy5eJFYrvuMF86PyGaoBDjdcnaRWV5k+O6HbFqmSeIiZXGqW01Z
         JHqW73FkNfV1mMbpoQzH7veK/XlPMH52kWmTStfnANzJ2nyWpkcc918H5/3oiuuOLyiH
         aLQQ==
X-Gm-Message-State: AAQBX9e36yaZseGct95qcvjc1SjyW6KG/C8yQyc6+v3aWVb+MvaxpKKf
        IYa/KN82n3um3vcGKxmr7VgmTRNCrJgTen4whAc=
X-Google-Smtp-Source: AKy350aP0sVxOVbRdfaxygjd9Zkval2nVvpFquxKpaz0Y8pPfwIPacIOwyKNqxo+YZny2UHLm+5AUQ==
X-Received: by 2002:a2e:9ccc:0:b0:2a6:183a:9a13 with SMTP id g12-20020a2e9ccc000000b002a6183a9a13mr1625313ljj.46.1680249009752;
        Fri, 31 Mar 2023 00:50:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p23-20020a2ea417000000b002934abfb109sm249539ljn.45.2023.03.31.00.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 00:50:09 -0700 (PDT)
Message-ID: <2872b939-a617-90ee-2249-9eb535559f07@linaro.org>
Date:   Fri, 31 Mar 2023 09:50:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V4 2/2] ASoC: dt-bindings: max98363: add soundwire
 amplifier
To:     =?UTF-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, rf@opensource.cirrus.com,
        ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com, herve.codina@bootlin.com,
        wangweidong.a@awinic.com, james.schulman@cirrus.com,
        ajye_huang@compal.corp-partner.google.com, shumingf@realtek.com,
        povik+lin@cutebit.org, flatmax@flatmax.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        ryans.lee@analog.com
References: <20230330234319.6841-1-ryan.lee.analog@gmail.com>
 <20230330234319.6841-2-ryan.lee.analog@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330234319.6841-2-ryan.lee.analog@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 01:43, “Ryan wrote:
> From: Ryan Lee <ryans.lee@analog.com>
> 
> Add dt-bindings information for Analog Devices MAX98363 SoundWire Amplifier
> 
> Signed-off-by: Ryan Lee <ryans.lee@analog.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

