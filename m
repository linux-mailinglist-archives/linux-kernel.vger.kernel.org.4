Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C22D6B83C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCMVKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCMVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:10:48 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1192C661;
        Mon, 13 Mar 2023 14:10:11 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso13047900pjs.3;
        Mon, 13 Mar 2023 14:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlbP4RMuI0UuGpDLkK+kTJ9DE1XKYPJgo0MhTNATv38=;
        b=cbKDqV0ze5AvyQmXeGBELpf8Ock5/8DBqbUwtBHfv3xAQzcnDfjxxQEhFrqJK9s1Lh
         cEBm3OrjM80MuXMJFIxrBVqh98wmesN09J+3t0fYSsYr4ZJlHayn0s0GxfOWpUfxZ1Gi
         G04v/us8Tgzbr+kQU3e/T6OwC/xJKLN0LecOArW/9vFJfLwp/dEHqAT19nB4SAIBtig1
         OCpvNNXvlwQ4hcEqx4orsr37UAek8m9B3d+02rxfmxmpQT31or6tTFP8wjopb9TwKdgt
         mwNVqZ3i6fA0oL20sV9TA/BTfxYFrcbvkTddpcAZSXdS6kwc4red/egMCDuaKTs5sAkL
         VfiA==
X-Gm-Message-State: AO0yUKVjZS1tv7Fg8BcM9KeaEjvtQwqKMuOReXnenSTXh/Y/cqoCEwJp
        zO2ZGwfkpytkyMFM/7BQ3s0=
X-Google-Smtp-Source: AK7set+QSfPstXZPjDc6o/gv7ERNFNhqrNhy/iy0ONgwO/xGZ//yARXWv+44cLD9sfmyrcpV81ZI6w==
X-Received: by 2002:a17:90a:bd85:b0:23b:d506:226e with SMTP id z5-20020a17090abd8500b0023bd506226emr5992734pjr.42.1678741770779;
        Mon, 13 Mar 2023 14:09:30 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9cdb:df66:226e:e52a? ([2620:15c:211:201:9cdb:df66:226e:e52a])
        by smtp.gmail.com with ESMTPSA id l10-20020a17090aaa8a00b002311dbb2bc5sm273276pjq.45.2023.03.13.14.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 14:09:30 -0700 (PDT)
Message-ID: <5ee20e75-8a61-be89-5302-45f390a0cbd6@acm.org>
Date:   Mon, 13 Mar 2023 14:09:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5] scsi: ufs: core: Add trace event for MCQ
Content-Language: en-US
To:     Ziqi Chen <quic_ziqichen@quicinc.com>, quic_asutoshd@quicinc.com,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <1678699023-6645-1-git-send-email-quic_ziqichen@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1678699023-6645-1-git-send-email-quic_ziqichen@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 02:16, Ziqi Chen wrote:
> Added a new trace event to record MCQ relevant information
> for each request in MCQ mode, include hardware queue ID,
> SQ tail slot, CQ head slot and CQ tail slot.

Added a new trace event ... -> Add the MCQ information in the existing 
trace event ...

 From Documentation/process/submitting-patches.rst: "Describe your 
changes in imperative mood, e.g. "make xyzzy do frotz"".

> Changes to v1:
> - Adjust the order of fileds to keep them aligned.
                         ^^^^^^
                         fields?

> -	u32 intr, doorbell;
> +	u32 doorbell = 0, hwq_id = 0;
> +	u32 intr;

Since hwq_id can be assigned the value -1, shouldn't its type be changed 
from u32 into int, int16_t or int32_t?

> +	struct ufs_hw_queue *hwq = NULL;

Is this pointer only used inside one branch of the if-statement below? 
If so, can it be moved under "if (is_mcq_enabled(hba)) {"?

> +		"%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x, hqid: %d",

Consider changing "hqid" into "hwq_id" to make the trace information 
easier to understand.

Thanks,

Bart.
