Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B570639288
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiKZANi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKZANh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:13:37 -0500
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5A22FC35;
        Fri, 25 Nov 2022 16:13:36 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id a9so1925685pfr.0;
        Fri, 25 Nov 2022 16:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru1TywxZNaC39NNAePmlRI5Ov25vqXZAwJ5dyy9w1u8=;
        b=giWJg+aKoAuS8/m6p8PaqTAFjtuubho67laSUP1Yjk8O/diaATT0IsZvmyumyGCJna
         TCuZ8E9oD8JbVTcsZqdR5HRpvqjyL5Gz859WTCh60Lw5vAyyu+PQCsWaTefBWbgkCsSG
         fwsOoB78NT3voSI7xTcVQZL/61ohBm657FLgmgtQu+meP+sXKkRyp899ALABNrIaK0m6
         Ca60N9rvI/BmLqe8ICWmLnTPnlejnzu4+ZmCxnYQ8d2adCth4GJcM1G7D5OqaEvw8vLq
         7k/26Al0+a7o8R1G4ktJpCtNedap2SLnz0YndReMb9fLAXNoXTNPKRtOKm1WjE+K1eq+
         TDgA==
X-Gm-Message-State: ANoB5pmLIJaptDKf5k3UkV0d8v/7CtmglX8nAzB8AOs9a44qYlpkmJZ8
        WuayHaREZEfA46bnBWssFBeUxVKhFAI=
X-Google-Smtp-Source: AA0mqf60kRzKNKZY5tUXsPjMG4NwiZtljH37aPFWHxrlYGPPiarjdiJBIDmEe7Z4r7GpbtVteTqikg==
X-Received: by 2002:a63:5422:0:b0:46e:be03:d9b2 with SMTP id i34-20020a635422000000b0046ebe03d9b2mr17779659pgb.406.1669421616206;
        Fri, 25 Nov 2022 16:13:36 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b0017f48a9e2d6sm3906284pln.292.2022.11.25.16.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 16:13:35 -0800 (PST)
Message-ID: <c260691a-e047-0d23-fbb2-b903466eef7d@acm.org>
Date:   Fri, 25 Nov 2022 16:13:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [External] : Re: [PATCH 2/2] scsi: core: Use SCSI_SCAN_INITIAL in
 do_scsi_scan_host()
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221121121725.1910795-1-john.g.garry@oracle.com>
 <20221121121725.1910795-3-john.g.garry@oracle.com>
 <83c29cc2-9bf4-265f-4f8a-ab83d8b6271b@opensource.wdc.com>
 <347d0e04-65d1-b735-75eb-e8358c91c08a@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <347d0e04-65d1-b735-75eb-e8358c91c08a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 05:48, John Garry wrote:
> cheers. As mentioned, I can combine these patches if people prefer.

I'm in favor of combining both patches.

Whether or not these patches get combined, feel free to add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
