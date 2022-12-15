Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB064D73C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiLOH0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLOH0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:26:01 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA71020363
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:25:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o5so2129285wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mm2wMOJBU0KY5CK4G5XuPJWnbMPqw3bzwZnGj//J0bc=;
        b=IJ027xJjO2+v9bEloG9slnX6gLRHg9t1MMvGfOevcGjukcWsGVH+SAPCaW5j18HGrf
         mSgKQ8uYEIFewcYpKNLqjLRCJmDZ7Hf08tzaGsZCcYE3ktur3K1fNrOy4+PcNT2SAhRr
         gxG5rA8umj7lHwqtDJIGp4Moa0b7Re2Z1+NGxDwQJJEn1DD7aj0XbCGfzk0ChWBYoAwE
         jmpbTzF1TSUCKxVBlI90TX59HuE+t4WHUMgtFRg0V1tWTFMHs5sqE6azh0haI7p2DGCb
         2uDakyUpVab9ClcmoHWANWAkdm8bHEQ1NARrvXHcu1d6HqcYaaBsYGqWEuKDVz7BEWXd
         7YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm2wMOJBU0KY5CK4G5XuPJWnbMPqw3bzwZnGj//J0bc=;
        b=UpAzWGl+Xm9vAY/Gg0egrLsowRckjG4DDtOvqrpNz+KS3Se9tpP9EEb60g68aWSuAD
         Mp2+VQlW/aruy442kDu9x2L17jqnOdqDTDMaspmPYG6RPQmnbHMdtaGT+zK/LtM3tphU
         4yEH0/8WyeMuuaEfqNSmXtAfIQ0gZ5Po5tItxNw+nhDEBGnqRJuEuZLcd2Q3DHttqHNF
         yUodNFVn8IFo/f2TXterKldwl34hQQ484Dkic/gDQUXPZDRuzOfQbHCW4N1a9p84LvMx
         dxFx2cCNTVCFY3Bjjp0GmPTPvZx+NXzjLZESlWfnzHMq/YBe764p83tJ01LZ8ZsWw8ZJ
         l6qg==
X-Gm-Message-State: ANoB5pmiNAfRM2TLij0625kJAZ5hqlykGTD0un6ieBrPOgHZDMiRvq3o
        d/dUNfEND4W4SUu0Pk2XRruQAw==
X-Google-Smtp-Source: AA0mqf6FUW6cVCTyvzhNaccE170mxSEmlyha2ZZvhJLzGO2eAwd7HoAqxqtaPydtZy7SLmvbY+rnjg==
X-Received: by 2002:a5d:5187:0:b0:242:9e8:84b6 with SMTP id k7-20020a5d5187000000b0024209e884b6mr16499660wrv.13.1671089157351;
        Wed, 14 Dec 2022 23:25:57 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d67c9000000b00228dbf15072sm5082277wrw.62.2022.12.14.23.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 23:25:56 -0800 (PST)
Message-ID: <ac2d90e2-6fc3-98dc-8c73-936132b6c8d5@linaro.org>
Date:   Thu, 15 Dec 2022 08:25:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/2] docs: remoteproc: Update section header name
 requirement
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, mathieu.poirier@linaro.org,
        corbet@lwn.net
References: <1670924929-26507-1-git-send-email-quic_srivasam@quicinc.com>
 <1670924929-26507-3-git-send-email-quic_srivasam@quicinc.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <1670924929-26507-3-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/22 10:48, Srinivasa Rao Mandadapu wrote:
> Add section header name requirement specification in elf segments.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>   Documentation/staging/remoteproc.rst | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/staging/remoteproc.rst b/Documentation/staging/remoteproc.rst
> index 348ee7e..3125030 100644
> --- a/Documentation/staging/remoteproc.rst
> +++ b/Documentation/staging/remoteproc.rst
> @@ -245,6 +245,8 @@ if the remote processor is accessing memory directly).
>   
>   In addition to the standard ELF segments, most remote processors would
>   also include a special section which we call "the resource table".
> +This resource table section name may have anything appended after it,
> +but it must start with ".resource_table"

What do you think of:

    In addition to the standard ELF segments, most remote processors would
    also include a special section which we call the "resource table".
    A "resource table" section name must start with the ".resource_table"
    prefix, optionally having a more descriptive string appended. For
    example, ".resource_table.my_rproc" is a valid section name.

Regards,

Phil.
