Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63390731CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbjFOPpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbjFOPpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:45:36 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C210F2728;
        Thu, 15 Jun 2023 08:45:34 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-558b04141e2so1688008eaf.0;
        Thu, 15 Jun 2023 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686843934; x=1689435934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7uP2GIK/pJgBMyLexQ3e7d03sdWuNsvi/ReuDEmt6yw=;
        b=Qwcly8aXM9oXm39Xr5Zsr1LNNGDQKCua51uPH+5kg/H7DfqImXe3gyUq6otsAEf/AF
         tFZbxMTcRs6NWaPOXI/hHGVdh1FuRIuqo8bLOMST2wBFbAD6VdGSZUxjSIfAesT9rcPn
         Fit3KGGWSS6m14HDc4ZBrO6xUj22FybcJU/MfR0Wsg38uW27idBNu7c2iocsBEnSmOQr
         walzJNexY/Cp+2V/YAFCXd3SAGLGeojsfND/VtOhksAIS/gEjeF54LHh/7tSkUeL6ol5
         08hj+l513uCE2/7yHQA4PH6kZIQkHBQQnCB6OJae3OPne5Xd0IaWFbJGZ5rYYlbpmh3K
         1Yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686843934; x=1689435934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uP2GIK/pJgBMyLexQ3e7d03sdWuNsvi/ReuDEmt6yw=;
        b=ZF0bogKG3V6CaKXeYB2/wk817yckxdsMqFIMbRMfe+izoQq9V9QOI6MgvIQm4VZ/Y0
         Havp8atflzYj0PDprudoYs2VhJiQiLE7kK7B5y0IvbMSE6Iq9C19tUOanocc73ThG084
         pexepsZPm8u6mjTcBoP85O6NzlEhGTvAlrALK78Z9aZfiH5ZR/HgP0MKL0Rs8pir5FO2
         sEq6dxpsra6RpEl5QZ70xt3A+SXKMCCCeji8EUC+DS2eps0+rejcixFxkpmJktopPMMo
         HPYuPSW7Hkip29IYyOCYsBWlsd3JzlW1kRyO29nGHogNabmAQnoPqzP32Qo/3CX+ZBCe
         rF6g==
X-Gm-Message-State: AC+VfDwnQBOLAbSgq6hadeIWn4GCDUwZPVUCz86SviAwfgzCyIvsaBpr
        6bITIOc+DBf2lEwMW3TPVlM=
X-Google-Smtp-Source: ACHHUZ6BOIWCI6ss6eWnwOMKIBHAp+H7S9m9epWiLO3mc6eaUeUkaCMPA8xHRQ+o2z2X4fr6o6tRww==
X-Received: by 2002:a05:6820:319:b0:555:722e:3ce with SMTP id l25-20020a056820031900b00555722e03cemr12060105ooe.9.1686843933676;
        Thu, 15 Jun 2023 08:45:33 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id s3-20020a4aa543000000b0054f85f67f31sm5984474oom.46.2023.06.15.08.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 08:45:33 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <11412b24-c107-247b-5e6f-1a95a737a9f7@lwfinger.net>
Date:   Thu, 15 Jun 2023 10:45:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC 1/1] wifi: rtw88: Add support for the SDIO based RTL8723DS
 chipset
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Ping-Ke Shih <pkshih@realtek.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20230615142044.1357257-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230615142044.1357257-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 09:20, Heinrich Schuchardt wrote:
> Wire up RTL8723DS chipset support using the rtw88 SDIO HCI code as
> well as the existing RTL8723D chipset code.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> 
> On my Lichee RV Dock board this patch is enough to make The RTL8723DS
> work. But unfortunately after running some time the driver crashes.
> My impression is that the crash is not specific to my patch but must
> be hidden in one of the existing functions it is invoking.
> 
> This seems to be related to not checking pkt_stat->pkt_len.
> 
> My kernel was built against v6.4-rc6.

Heinrich,

Martin Blumenstingl has written a driver for the 8723ds chip. It has been merged 
into the wireless-next tree, and will be in mainline kernel 6.5. In addition, it 
is available at https://github.com/lwfinger/rtw88.git.

Please try it to see if it files your crash problem. Several users of rtw88 have 
reported success.

Larry


