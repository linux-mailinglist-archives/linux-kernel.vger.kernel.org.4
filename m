Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A548470A2E4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjESWq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjESWq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:46:58 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647FAFE;
        Fri, 19 May 2023 15:46:57 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ae85b71141so9461265ad.0;
        Fri, 19 May 2023 15:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536417; x=1687128417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDYo2RuaT7h147GhvjSkJ6eFYV+ISM/8wq3TGBb7iAc=;
        b=PWk7Sj2RZr+H3qQE2eg7VhPhroykdYlQvAwbQvBsAIlADCFeIrmUG/OjEeau1C3uAp
         YkJPkCr8uFqm7akRBvUaNkuAaW+M6uHvag3PFuFWYSSjyNHY5irPCrctt7zxLIQ6dMK3
         7XpgPAIun4R4rAS9TY+lb+ZEMeUlLo2w1Mr+sWWWIkMqvpfk6aTVG0XWt9YW5zAsX6Sn
         4vdFDapsnLG01/n1Q5VdE7zDYsGcknP8AIm6ufXwK2FIsxec3VaL3vneI4KTocsS2cmR
         Suux+iYMUlB6QBlZotIygCXGRV48bAEIhPr4q6mlSA2vx88mpndmgICNHU17tVnehqgE
         4arA==
X-Gm-Message-State: AC+VfDwksU73O/dP59blwMw5YXf1VodmB82lgzlkK4uV/hs0gxTiNczM
        Bm+ymEtdwUOdmilfHlWgyYk=
X-Google-Smtp-Source: ACHHUZ7B2eX0aQ1+ZttqtH64J7o4NS1g6keQAyRMbbNX7ydsGZZCigPnu0PEI0vCAly3aqX4QbltGQ==
X-Received: by 2002:a17:902:680d:b0:1a5:5e7:a1cc with SMTP id h13-20020a170902680d00b001a505e7a1ccmr3495810plk.58.1684536416808;
        Fri, 19 May 2023 15:46:56 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:102a:f960:4ec2:663d? ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id iw10-20020a170903044a00b001ac2f98e953sm123652plb.216.2023.05.19.15.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 15:46:55 -0700 (PDT)
Message-ID: <2f695901-c099-b286-a874-5cfdf9a0d7d7@acm.org>
Date:   Fri, 19 May 2023 15:46:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 1/7] ufs: core: Combine 32-bit
 command_desc_base_addr_lo/hi
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Eric Biggers <ebiggers@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1683872601.git.quic_nguyenb@quicinc.com>
 <7dec3a486501d9e30dfb5a70eed7c7661187b8c9.1683872601.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7dec3a486501d9e30dfb5a70eed7c7661187b8c9.1683872601.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 23:28, Bao D. Nguyen wrote:
> The UTP command descriptor base address is a 57-bit field in the
> UTP transfer request descriptor. Combine the two 32-bit
> command_desc_base_addr_lo/hi fields into a 64-bit for better handling
> of this field.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
