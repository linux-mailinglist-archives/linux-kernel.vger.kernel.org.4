Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2526E9EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjDTWUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjDTWU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:20:28 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA26272D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:20:27 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2a8bbea12d7so9386531fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682029225; x=1684621225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QW2zFEjgoUsaSsxeB6v7NVOeo+doEcmv6Xwkw75TFw=;
        b=qX9nkfpbyJjng6ZSha7rHGcg4LudKd3zSrQNn0RR5uF1qMb/HDTzv5Ygyp7yz5JUby
         x+O1vf9GjBtAXRMaFcMQJsseHfBHftKtS2GGSlKHy6bJ+s58OX012Te2Hj3Ie0m+VjI3
         TjrB7NMPSfeFaDXX1tzrCf/EDlBBycUodM8JCXTkDRvL2kzdvZz+83MKUXhIgwHnHURB
         FXHSEHoku5wDTH4+Ij2eO44jPWiA6hQpXJHCdbgp+gJ+crH+oZJQKm6s5DvSstYRE/cC
         RVSv1Ga5xyYN0ZIror7eizBU1aaHZbRhjipk/BAOsRSFaW2x00OrZo5jEGbDL4z2tqMK
         gMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029225; x=1684621225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QW2zFEjgoUsaSsxeB6v7NVOeo+doEcmv6Xwkw75TFw=;
        b=c2zfSx91iXgFwrsFA6xxx4F5wbaZicOowe8i7Dfy8bOIyv/HDKj36kjjYx9w6tFA0x
         +1fIXdCJOn7JerK0oPbCym9rdt2q8uA/twOJfrF50w1wefjwK5yF+gi+l/puUTB7/fKU
         GaIN6IkdSUF3CbVaO0Aycm1IoiqqM55wa1JvpEet/F6fMbh0vIscxKuLpigLcWkfPC2m
         JUrXVGs4GHJTzmmzYRGF4NNTYY5sl/ox29zdOQOF0vHjEKU2bfmoYS8GtNmhe0mMqaso
         EMJtVsfj+64Z0PQv2O9dk4DCbIgZdgX1JCtjMj1EpAecSpIlN1uuSUkUkvls3N6UNelS
         hQkQ==
X-Gm-Message-State: AAQBX9eY7K2IzlwqL0QbiR7fcDgpYexJAL1Rrsv3KqXR98uwXLYuYoeM
        QA8G7Nfgz7Q9QMjxm+HWIoz8OA==
X-Google-Smtp-Source: AKy350bMn6KVhj21+we3mlghC+POksK+s8xQxvWGGN3UFAziRJEF3Lev22U9KKRMAJ1zT38co8wU8Q==
X-Received: by 2002:ac2:4891:0:b0:4ec:8d97:9479 with SMTP id x17-20020ac24891000000b004ec8d979479mr777600lfc.20.1682029225592;
        Thu, 20 Apr 2023 15:20:25 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id n5-20020ac242c5000000b004ec88753502sm347146lfl.111.2023.04.20.15.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:20:25 -0700 (PDT)
Message-ID: <61bdd089-89b7-749b-95bd-c7e61c396e29@linaro.org>
Date:   Fri, 21 Apr 2023 01:20:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Freedreno] [PATCH 1/3] drm/msm/dpu: Drop unused members from HW
 structs
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        freedreno@lists.freedesktop.org
References: <20230418-dpu-drop-useless-for-lookup-v1-0-b9897ceb6f3e@somainline.org>
 <20230418-dpu-drop-useless-for-lookup-v1-1-b9897ceb6f3e@somainline.org>
 <7ad86cd9-4b30-e7f1-780f-2c1c7093087e@linaro.org>
 <cd308be9-5420-6d75-da23-e844107ec275@quicinc.com>
 <2ujeakobg7oulzarvzjktx5elo4ckpjq5pbknr3jx3h43snmry@yd4j64s7tqy5>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <2ujeakobg7oulzarvzjktx5elo4ckpjq5pbknr3jx3h43snmry@yd4j64s7tqy5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 00:39, Marijn Suijten wrote:
> On 2023-04-20 08:46:46, Abhinav Kumar wrote:
>>
>>
>> On 4/20/2023 7:33 AM, Dmitry Baryshkov wrote:
>>> On 18/04/2023 02:14, Marijn Suijten wrote:
>>>> Some of these members were initialized while never read, while others
>>>> were not even assigned any value at all.  Drop them to save some space,
>>>> and above all confusion when looking at these members.
>>>>
>>>> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
>>>> Fixes: 84a33d0fd921 ("drm/msm/dpu: add dpu_hw_wb abstraction for
>>>> writeback blocks")
>>>
>>> The fixes headers are slightly questionable, as unused fields are not a
>>> bug. Nevertheless:
>>>
>>
>> Yes, I would also not treat this as a "fix" but just cleanup.
> 
> Ack to both.  This seems like a fine line to me as the fields are not
> contributing to anything except confusion.  Specifically hw_mdp which is
> never initialized and may accidentally be used without realizing that
> it'll stay NULL, but that is again up to the developer using the field
> at that point.
> 
> Feel free to drop them while applying, or should I reword the message to
> at least still link these commits to mention the origin of the unused
> fields?

I'm fine with having the Fixes removed. If you can send the v2 reordered 
& with tags removed, that would be the best.

> 
> - Marijn

-- 
With best wishes
Dmitry

