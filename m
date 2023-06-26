Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380473DF60
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjFZMhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFZMhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:37:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061C9118;
        Mon, 26 Jun 2023 05:37:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98df3dea907so270122466b.3;
        Mon, 26 Jun 2023 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687783018; x=1690375018;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ts7z/BAypRpTsOZNvrC0wa2ErrI/X5kofekA6oN1UMo=;
        b=GxiPBR0eAmZ205C+pO4K36/cTkUmcvtStCKKV8FBZStHaRYISCMpy4+wJ1lMRN1muG
         ZDHTHRnXmnWxu7QEEepV3UnGx+AKYPJwr5LnLR64hsdQBvY/3YrXdKG1oIvgXmG3DlWQ
         cfsNWzKpIhQckBsBFeB/NYweo6OnVmHXmwhr+Dsjqj6rutgc9es1ZmwATMn2AwUiwzYS
         cCNhT6MBUuAt7OnBS2uGg7jVp9Dff0xJSKoYhyktzIC57DtcCcqmAW/VhDA8JvUGRZWY
         Au8Qn68xF0ZzcDd1cgEqOSnaE8TXNqkLeUyQFqlT/XpRhETPYjuDx7HffEf6a7/AwA4R
         E4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687783018; x=1690375018;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ts7z/BAypRpTsOZNvrC0wa2ErrI/X5kofekA6oN1UMo=;
        b=AUlm+KyfJ5mL0EwkGH6st9Nh5UGj5XLpqNHr051+Ar1Qp2m6gBqvpbB+S4MgNp4NhP
         9lL/gHx2TWGSMWqqd6ywWK7PA9o+M8hnEjPrUVkqMHupQsPXfZmjtXGVtMKr0atD2zno
         m9RpIb++Aa1ffAkn4A1QVvx8qy+3bz3GG7orWUBovYKujeCZ2e7ksP+LSylpz/r0Ac3X
         KVymGHR6kiUN7IT3awtPJpWXuAMWjrGxvuEBSQISutBUQ4wrFP2PizfiQ8YxdoB5yiBb
         aaF5bCeL/jMFr1S6tjJFuSGlXHK6e/jZCMgtsTykkX26WODYVZEw5d7XIGMO3Es9TIma
         dxKw==
X-Gm-Message-State: AC+VfDxisRsipQbdDxQg5ByUnP43yP/YpBKPu/7vmmIAdLqwLyTdGUgX
        VpnUYtXZ8ymV60bfS2VKpBi6eCvi2GmUOw==
X-Google-Smtp-Source: ACHHUZ6VbjANrhtBGw/tYlfdEP2b8nnR8n01SyBT0WU3lVqNxVbA7sBbSe7GcYdtwFgAKQGPdBjvlQ==
X-Received: by 2002:a17:907:d8b:b0:98c:f488:4202 with SMTP id go11-20020a1709070d8b00b0098cf4884202mr12025832ejc.15.1687783018196;
        Mon, 26 Jun 2023 05:36:58 -0700 (PDT)
Received: from [10.176.234.233] ([147.161.245.113])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b009893650453fsm3251148ejb.173.2023.06.26.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:36:57 -0700 (PDT)
Message-ID: <2d034edbe84092fa4030fa2bf366d4b58c4b9405.camel@gmail.com>
Subject: Re: [RESEND v2] ufs: core: Add support for qTimestamp attribute
From:   Bean Huo <huobean@gmail.com>
To:     Arthur Simchaev <arthur.simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     avri.altman@wdc.com, Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org
Date:   Mon, 26 Jun 2023 14:36:56 +0200
In-Reply-To: <20230626103320.8737-1-arthur.simchaev@wdc.com>
References: <20230626103320.8737-1-arthur.simchaev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-26 at 13:33 +0300, Arthur Simchaev wrote:
> =C2=A0
> +/**
> + * struct utp_upiu_query_v4_0 - upiu request buffer structure for
> + * query request >=3D UFS 4.0 spec.
> + * @opcode: command to perform B-0
> + * @idn: a value that indicates the particular type of data B-1
> + * @index: Index to further identify data B-2
> + * @selector: Index to further identify data B-3
> + * @osf4: spec field B-5
> + * @osf5: spec field B 6,7
> + * @osf6: spec field DW 8,9
> + * @osf7: spec field DW 10,11
> + */
> +struct utp_upiu_query_v4_0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u8 opcode;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u8 idn;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u8 index;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u8 selector;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u8 osf3;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u8 osf4;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__be16 osf5;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__be32 osf6;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__be32 osf7;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__be32 reserved;
> +};

Hi Arthur,
In fact, this structure should be a "Transaction Specific Fields" in
Query UPIU for all query functions. By comparing 3.1 and 4.0, you can
use current utp_upiu_query{}, because you only want to pass 64bit TS.
Or you can change utp_upiu_query() to make it more uniform to meet
various query functions.

Kind regards,
Bean
