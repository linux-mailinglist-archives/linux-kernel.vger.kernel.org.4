Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF863C85B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiK2T1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiK2T0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:26:31 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F479303CC;
        Tue, 29 Nov 2022 11:23:56 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id ns17so6795500pjb.1;
        Tue, 29 Nov 2022 11:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARJqQMnVzJEz/Ay9uXEGNb3SFN1+JSUcIWe4lkCF+yM=;
        b=BT/h2OgknxiDjpKjrvM8KGfTtJ97nshRukmKamntS50bOy0Zs68en86VcEkOhG5ZlT
         QO3v6aRE/8gwMzIpSH5hfJO3uyI/ayPuThrchcY9ZqdQ2bttO1+CftCYJicKzHHg8krO
         dMK975rpd/dr03WBdwM24cpMeVzSoEvsXeUIz3pdfU4C5OiZwGJ6bIiZOqoZcE8OHzOj
         qPLHCMbbamN1fQnOGJ6PX6ingWsYo52+GVGqH2ArkHQ+wtRAfWIao5f8QvaQAZGcDM0H
         o5Zh/lFEt4UY3skzvX6904hcnlxfP1ZXGNhPSVNR4jEeCQ19r/6cN6oBBFvQ/+hYwvTA
         maqQ==
X-Gm-Message-State: ANoB5pl7HE0/CwuoaSrx7Tp8p8NpC0H5mvwaH2cWx7Qg5h3NeKCw0F+l
        jHjITWlIxSkG2nH7TcbF0yQ=
X-Google-Smtp-Source: AA0mqf7BYTyAgcSc6HnkChJd3jiCeFXaSSWFqiJpCRWWgWsFAFYe3l5nhvG31lMzt7+yJX6FLzd3QQ==
X-Received: by 2002:a17:90a:de91:b0:219:5f45:7626 with SMTP id n17-20020a17090ade9100b002195f457626mr750736pjv.119.1669749835446;
        Tue, 29 Nov 2022 11:23:55 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:7d15:8e62:30bb:9a14? ([2620:15c:211:201:7d15:8e62:30bb:9a14])
        by smtp.gmail.com with ESMTPSA id b6-20020a170903228600b00188fc33e96dsm11232327plh.198.2022.11.29.11.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:23:54 -0800 (PST)
Message-ID: <f30fed7c-45bc-9b71-9c57-c8d9ec395597@acm.org>
Date:   Tue, 29 Nov 2022 11:23:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v7 09/16] ufs: core: mcq: Configure operation and runtime
 interface
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1669747235.git.quic_asutoshd@quicinc.com>
 <e90498f7e1ddb751c62086f535acca56454c7b35.1669747235.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e90498f7e1ddb751c62086f535acca56454c7b35.1669747235.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 10:53, Asutosh Das wrote:
> Runtime and operation registers are defined per Submission
> and Completion queue.
> The location of these registers is not defined in the spec;
> meaning the offsets and stride may vary for different
> HC vendors. Establish the stride, base address and doorbell
> address offsets from vendor host driver and program it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

