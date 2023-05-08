Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290E66FB614
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjEHRrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEHRrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:47:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E50044A0;
        Mon,  8 May 2023 10:47:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ab0c697c2bso45501755ad.1;
        Mon, 08 May 2023 10:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683568021; x=1686160021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=czsxLKCoo0lix8/lULwsLUxbA5i8x2xSGxfZ91c4k0c=;
        b=fvniQwofAddh57zRR4OfAxTeX/eSWcBv/DyxplKRcTzaOLpMPtP3kqtLOGm6qsSpNa
         1GpmC4uOokEZrG9JdLh7U+3DmVFyETFmuHHjQkxaGnBm+DWKJC+K7avq8oIVYeTg3Tw3
         N+aSzeyhcKPO+/7P4z2rJskzun9X2R5UhOHVHIqdRaGjPeUZlh3S03nO829gwaJYsph2
         u2P7h3H9UQ773gQkkUbJAPbWFcCLWZhK1BHJl/leMN9yZlB47SWR9bI6DKCMaJLLC7zx
         cn5WDFSicM94aiCFzm3fifpLHzT00C1ko1Y+rj8MVtV86UMsmYg3shLsmzUZcii8uUqN
         VY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683568021; x=1686160021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czsxLKCoo0lix8/lULwsLUxbA5i8x2xSGxfZ91c4k0c=;
        b=gZlgBx/+9xhp7zVvvz4PPgxXq5sJqT1TRkH7k9ads052NHrcR3m+eybSvazI4apALA
         xyNc9q1wZ8PvW35rxdDRYlM2rlfYROqV02cVAdh/Q9NQXemt/647hFMTfLg8gSGsz2Kq
         q6cN1M2hsYChmvpgSEtEXkXaHrBGrrCrailWSFg+YHoX6iKwYMKon5whlQTnI1azPUTp
         Zg/4BkJCY6dKaRy0IIKTOZTCa3ZAd8E6WcLlH8TPj+f2Rjahhqd2wPpiVnhZEktzlpRK
         yvmh/I9jwpartk5ADeOuArvKK3CWII3l8b7Je8VhZMkIJv32fupxT2JtrXPRtIE6eB7c
         K51A==
X-Gm-Message-State: AC+VfDzg0qaNUnswAFx1lo2L7tKs2i6cDjl6MCaj9FRwHyhkr4/3fbqT
        96MCxQaVJtCdVADq8sOTP2o=
X-Google-Smtp-Source: ACHHUZ78hAq5WpUbekPixr9ZSGOhMWVi+xN+4Rg8VG4EswAYXzutHVc46QmC5MytW4jlEQlwWjEXAw==
X-Received: by 2002:a17:903:11d1:b0:1a9:8ba4:d0e3 with SMTP id q17-20020a17090311d100b001a98ba4d0e3mr12946161plh.59.1683568021470;
        Mon, 08 May 2023 10:47:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x6-20020a170902ea8600b0019c13d032d8sm7468862plb.253.2023.05.08.10.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:47:00 -0700 (PDT)
Message-ID: <2861b900-1295-e565-63e6-a1463d793ce0@gmail.com>
Date:   Mon, 8 May 2023 10:46:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional parameters
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230506182428.25343-1-quic_nkela@quicinc.com>
 <20230506182428.25343-3-quic_nkela@quicinc.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230506182428.25343-3-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/23 11:24, Nikunj Kela wrote:
> This change adds support for passing shmem channel address as parameters
> in smc/hvc call. The address is split into 4KB-page and offset.
> This is useful when multiple scmi instances are using same smc-id
> and firmware needs to distinguish among the instances.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

