Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D759730745
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbjFNSRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242178AbjFNSRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:17:09 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B94E4D;
        Wed, 14 Jun 2023 11:17:04 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6664e4d8fb4so737032b3a.3;
        Wed, 14 Jun 2023 11:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686766624; x=1689358624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7cNlD/Z5+lemaLmb8RcyDmpNxTE6yny9wQ3HkylU2I=;
        b=j28X3+NZoprIA5fbfMLFLK02nguxmjULmALo/JV++kVxo/33R4Xl4ViMbcea4Pf1/t
         a4qAzvWlsZlN7IEQ691ZdeOHL2S8WiDfNJQ7NR4pMgRx64u/e1vrvA5Rp7l3oofzqlyk
         lVKjTQbGJxLMOyR3Jyaot2XhHUouT/Qft9QLBfOH4ZKsakbWCTFf4cxwqZHq0EfgPNJt
         sStlja1VjuanLzqVraTfML26YeC6VpK7+PWKhN8JgLztOt8rHIfJNIdOUk5j4lwHYSID
         T9YJsDhjtjEm8FskGzi3ooyefHEg5oweJJCchmRMDb6C5uvhjDE5S5i72u/YSFmquyLp
         Mkqw==
X-Gm-Message-State: AC+VfDws5CFUYfvhTbLs9hz950X7rnBdcYi55RWJu/smjkvgwYBNqPn4
        B/ZiZ0DggHdwRGPuuMzqe4MRzGJT6ho=
X-Google-Smtp-Source: ACHHUZ4aVsPeYCrcmIX9u3FoQzws2b54/E5DCVI6EBEBNEIHrv3yscX1MeIz19hHXC0MWcpICNJC1w==
X-Received: by 2002:a05:6a00:1915:b0:666:8836:2963 with SMTP id y21-20020a056a00191500b0066688362963mr506605pfi.14.1686766623920;
        Wed, 14 Jun 2023 11:17:03 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id q23-20020a62ae17000000b0062e0c39977csm10686645pff.139.2023.06.14.11.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 11:17:03 -0700 (PDT)
Message-ID: <8822893a-6738-66ca-ef99-65399d685ef9@acm.org>
Date:   Wed, 14 Jun 2023 11:17:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] scsi: qlogicpti: Remove unneeded semicolon
Content-Language: en-US
To:     baomingtong001@208suo.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230614085236.43022-1-luojianhong@cdjrlc.com>
 <5b703018fcab06a574c713c318df1112@208suo.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5b703018fcab06a574c713c318df1112@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 01:54, baomingtong001@208suo.com wrote:
> ./drivers/scsi/qlogicpti.c:1153:3-4: Unneeded semicolon

That's a very short patch description. Although I'm not sure this patch 
will be considered useful by anyone, please mention the name of the tool 
that has been used to detect the unneeded semicolon in the patch 
description.

Thanks,

Bart.

