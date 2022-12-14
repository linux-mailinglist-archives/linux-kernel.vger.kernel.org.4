Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9481C64C7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiLNL05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLNL0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:26:52 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59C2DE3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:26:51 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u19so25243874ejm.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8sI/OlmkzwMUT63/vUfwGkH9X64hzL0XvDl7sOCKGAY=;
        b=ju6DBtndp6BiutwgFkPxIr1Sb75NoMEnsbL6DFC5c06KCkZl0Ti0wwR3UEpZDNoTdt
         vsTkOnUeJ8VL/BWudUUMM9aQsMe+iQzN+B4ZYxkGRWGxLCtpgbRgiafdLQmbsNPC2/Kj
         L4oA3fKDyX+F3HoUuoLu3kiKuN+YC85n2Bj2aGfGe5pmWaRF9hqCIOScUzF/v85PHvCh
         viohLX0MEH8OHLkQYY6ZttlwGgaF2oYmV02lR4iDeKmcTEM6PQ7s4Xjvhv+xPgt0YWIo
         MaT4CLWzi6rJ9DHOoXnzWFXE9psl01pVo4KlXxMGLGKTK8PwfpgOENUbCui3rrwEnKX/
         YAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sI/OlmkzwMUT63/vUfwGkH9X64hzL0XvDl7sOCKGAY=;
        b=0IoXl1ktGFafFJIA5cLEqbShRaiJRili5qhjGhlPt2157QuBEgyFdkqqFlCRVVNuyp
         ehhd3SBqUv3Kad3RHaGrRfHriqALlEkMg2BZ4aQrWDL9q7PnbGXI0AOlwpWRQNEu8p1u
         Uw/UgkAAnQBI4T2lJetYa/lM1vkbhnBQTHEkDxA2I1q019MuI49prsaUgPzxVINs1UVx
         0WJN+Kajf8drVSxWGWqD2zhe+ZsLGGbuPusiuyZR5HdjqWe/4xRMLfPfmcb37+2msVOB
         4utXfl/pdT2ys8dt/c8HC81rtkVpMgq0km8idVNEWAqPdMtfVi9DbYKpdmfGDV4XJ40b
         7S6w==
X-Gm-Message-State: ANoB5pnP78GayIQOP11SBUtZfN0YWgsxmQcWmme0qPR2iWEjQDm/J7t8
        +XcAWmxdoEnvavmhBCypQqknY3CinFw=
X-Google-Smtp-Source: AA0mqf7surnWyhUxoaQKzR3B2Zc2wNPy7das2seVxoCXLARKI0Tawwv1VZTkOv/ok2tjm3dab3Vl8Q==
X-Received: by 2002:a17:907:7e86:b0:7ae:3a0d:9a58 with SMTP id qb6-20020a1709077e8600b007ae3a0d9a58mr24708800ejc.8.1671017209713;
        Wed, 14 Dec 2022 03:26:49 -0800 (PST)
Received: from [192.168.1.115] ([77.124.106.18])
        by smtp.gmail.com with ESMTPSA id qx38-20020a170907b5a600b0078df3b4464fsm5813128ejc.19.2022.12.14.03.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 03:26:49 -0800 (PST)
Message-ID: <de84c929-4005-b3eb-517d-615cdee1dbc3@gmail.com>
Date:   Wed, 14 Dec 2022 13:26:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] lib/cpumask: update comment for cpumask_local_spread()
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20221213043248.2025029-1-yury.norov@gmail.com>
 <xhsmh359i71vg.mognet@vschneid.remote.csb>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <xhsmh359i71vg.mognet@vschneid.remote.csb>
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



On 12/14/2022 11:47 AM, Valentin Schneider wrote:
> On 12/12/22 20:32, Yury Norov wrote:
>> Now that we have an iterator-based alternative for a very common case
>> of using cpumask_local_spread for all cpus in a row, it's worth to
>> mention it in comment to cpumask_local_spread().
>>
>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
>> ---
>>
>> Hi Tariq, Valentin,
>>
>> I rebased your iterators patches on top of cpumask_local_spread() rework.
>> (Rebase is not plain simple.) The result is on bitmap-for-next branch,
>> and in -next too.
>>
> 
> I had a look, LGTM.
> 
>> This patch adds a note on alternative approach in cpumask_local_spread()
>> comment, as we discussed before.
>>
>> I'm going to send pull request with cpumask_local_spread() rework by the
>> end of this week. If you want, I can include your patches in the request.
>> Otherwise please consider appending this patch to your series.
>>
> 
> It would probably make sense to send it all together, especially since you
> went through the trouble of rebasing the patches :)
> 
> Thanks!
> 

Same here.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks,
Tariq
