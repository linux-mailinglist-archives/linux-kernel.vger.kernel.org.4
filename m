Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74446627D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbiKNMIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiKNMIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:08:00 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA036544
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:07:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y16so17810295wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0Chla6FrbvsRj/V7o93Jwb0K9dJDq2Z+82QL/7CPMc=;
        b=NU0DJYEl7x+p33l8H4eTIkVmbzTGMYwmrBWF0JqU20kwNL3WwShZM0I+Zt9PxTbTpV
         pIzqiwqouRIu55CvOpCYY1aM0/IozRM8SfvVIwNwHc73WpvVU4lM+MSKKCz7bd5cP1c1
         1J2aZ498vCXxcvDy82NnXgOWozRCNxPNIpAjePwdF9RrvS0dsx3s/k2OqhjTdFL3R2Jc
         GKTrAgzquYBlo++pdyHo2Y0aith7l0OsWRkdAt+/Nys9a6+NLSiLqFt8BN9aG2XmbIJd
         mSaWVfkytWAL8DZ5/GSE9+MLJB2sHKciVe1yRPCPmfgLKFhX6Ksm2TP9PhMqS0jlnEc5
         9cEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0Chla6FrbvsRj/V7o93Jwb0K9dJDq2Z+82QL/7CPMc=;
        b=REPT5fzXXaBLnl06P537wf8H/s1qY7c3A5Hb330MlU65qZCZyb0ztMj1u3eizzlbXY
         YLWGgcSeivywziDlWxa9bi4NQ8r8H7Vz+KOKKLnmdRu7ug7kiwjU7cL07Y71QDW0OQfW
         NG03HDURfe71UmimBZvgurQmpbcAudUPYtsOfNJiLFtXeh/bqhhO5NRfE2AQOVooFRnZ
         0YL1MFMtfXtPunz9nnZXcwg0yPghMtp/W4R8o04uBuSofH0NrsZhu8/MnA9aO6dxRb6F
         x8J9wQKW3leNWXFsDdy6UQLwGNPEKIXYR234nBqJ+XFDe85gDpAm0Ss1DQ7qgQNPigVZ
         zAWQ==
X-Gm-Message-State: ANoB5pmqt1BoqoEbAhW8zf4DHXvkllMpJvY7MxSrw+B8qMdsRFYOg0XF
        fUTKHBAu/kS76kXUkBK+n9M=
X-Google-Smtp-Source: AA0mqf48iZU6uRKsDDAM/vO3CslLT70Dh+24sB8ylByYPvNix4AxyR3/oAJb9j7gwCPlcvP+hZYcPw==
X-Received: by 2002:a5d:4110:0:b0:236:7cdb:3c8b with SMTP id l16-20020a5d4110000000b002367cdb3c8bmr7165739wrp.280.1668427670067;
        Mon, 14 Nov 2022 04:07:50 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b003c6d21a19a0sm13684389wms.29.2022.11.14.04.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 04:07:48 -0800 (PST)
Message-ID: <7d674c0c-4cff-d142-225d-80c3309a57ec@gmail.com>
Date:   Mon, 14 Nov 2022 13:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] soc: mediatek: Add deprecated compatible to mmsys
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@kernel.org,
        nancy.lin@mediatek.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221111082912.14557-1-matthias.bgg@kernel.org>
 <46c17d4b-d130-86a7-b5f8-73c30d7fdfdd@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <46c17d4b-d130-86a7-b5f8-73c30d7fdfdd@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/11/2022 12:58, AngeloGioacchino Del Regno wrote:
> Il 11/11/22 09:29, matthias.bgg@kernel.org ha scritto:
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> For backward compatibility we add the deprecated compatible.
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ...And tested on MT8195 Cherry Chromebook.
> 

Applied, thanks for testing!
