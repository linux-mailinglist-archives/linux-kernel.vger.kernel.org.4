Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34EA6FE610
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbjEJVUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjEJVUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:20:07 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5392D46;
        Wed, 10 May 2023 14:20:05 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64115e652eeso53409755b3a.0;
        Wed, 10 May 2023 14:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683753604; x=1686345604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWDN1RwlRHt3BhJW4jKrvFXQD86CLGXa9KCbrw3P78w=;
        b=at+432Lf722bkVNauntLVLrbbo6Y8t7ysoSwU9H+ZiKMSy2HAINqJyjYYIXbvRK0GO
         CkXXDEwtuJ0DHgzGl8TQIAQZ4XPt3GIOznqD1WwBEbCOPw5FJ0YOTfp2ScMc2jOyCovk
         joKEUkOv8yS7kLo2Gd8K7MO+P2mIpfIkA2ru1ERYD5lXe6Gl9WJXYypGq9+KtFekkUo6
         /ZkHVusdF4fQl3dw7rhkQkNpyPozm992aTTUAHm6V1R9D+uB2FsUXpkgIoIyzoPLrZMo
         oSUu0FMwdkiU/E+m3CXrGbYfeqkPBdBd6y07M7JWGdx5g+NR+DS5uLSYE/VAOcqEIZL/
         0AxQ==
X-Gm-Message-State: AC+VfDyO2s7JO1xtwzhPAMbdIX3/OzbZM1LIyjxHONHsiVHoqaY9VyVk
        VWLF6AfnYd5jJbKbSNnuRnAPSc0ZY7cBYg==
X-Google-Smtp-Source: ACHHUZ7VvFAzp/mYIANPvOoGqx8YnJq7GYGTj0bAtNjk4MpqTLcaEECje9cacoI6Lk0MTHfHPw5g0Q==
X-Received: by 2002:a05:6a20:7f93:b0:f0:50c4:4c43 with SMTP id d19-20020a056a207f9300b000f050c44c43mr21193080pzj.5.1683753604436;
        Wed, 10 May 2023 14:20:04 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:b447:995b:bf4d:6d9b? ([2001:4958:15a0:30:b447:995b:bf4d:6d9b])
        by smtp.gmail.com with ESMTPSA id j20-20020aa78d14000000b0063d375ca0cbsm3929271pfe.151.2023.05.10.14.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 14:20:04 -0700 (PDT)
Message-ID: <2adc2439-bfa7-c5dc-ca2c-609c98c9f924@acm.org>
Date:   Wed, 10 May 2023 14:20:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/7] ufs: core: Combine 32-bit
 command_desc_base_addr_lo/hi
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1683688692.git.quic_nguyenb@quicinc.com>
 <c05c3df353d18800cde800bd629f7dc4983c1402.1683688692.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c05c3df353d18800cde800bd629f7dc4983c1402.1683688692.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 22:24, Bao D. Nguyen wrote:
> The utp command descriptor base address is a 57-bit field in the utp
> utp transfer request descriptor. Combine the two 32-bit
> command_desc_base_addr_lo/hi fields into a 64-bit for better handling
> of this field.

The "utp utp" in the patch description probably should be changed into 
"UTP"? Otherwise this patch looks fine to me. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
