Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A9C6AE54D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCGPsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCGPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:48:06 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572885A6F;
        Tue,  7 Mar 2023 07:47:38 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id u5so14521575plq.7;
        Tue, 07 Mar 2023 07:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678204039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwziTOWSx5gQIjIikRUH/cZZiINMVMawOuX2ejCg0M8=;
        b=CRd5KlmPRtJ+3YrdKonwKCa3NsIsek+DDzpfeY4GtPJgZpQWZWS5HOEq01paDyE4Qg
         6pC++5q0r2qKzOaXM3z04uZBNbyBBn/xjkP/sGnhXuEVwskG56VAw7MLhZf0Yfzx3VeX
         LoS1WH/JCZMcLjit6KJoc3YXsZd3JNoY6Ro0fFS9EO0ve7E55NpdN0x3qD/GFDjXK9xT
         TFDnIk7HEsp0I+Mt/N1HugK9qXhL6XyRlfbmMz5/T/u9hdQcBWXrmReodvhFIg362trt
         nrqSr0kd5gKNBFTXCvPbvCjC1nISa35MyNm+5fKkMXwO2MirAHCczZNd5zZEtEGYcupa
         P4EA==
X-Gm-Message-State: AO0yUKWa4ttKxGRCci05X4F2qo79sWZ9dXhqiFLRxo1ckUIBG7YthoM6
        MNamj/SE6bOeW+/TfpRg3ak=
X-Google-Smtp-Source: AK7set9bOFD86hVEitetXq7V1awDY1Hh1VJBlAr53BoHItabMvkpg4xM4u+NWEpADacOF/57k82xdQ==
X-Received: by 2002:a05:6a20:a88f:b0:c3:cc65:165c with SMTP id ca15-20020a056a20a88f00b000c3cc65165cmr12350717pzb.61.1678204038588;
        Tue, 07 Mar 2023 07:47:18 -0800 (PST)
Received: from [192.168.132.235] ([63.145.95.70])
        by smtp.gmail.com with ESMTPSA id v9-20020aa78089000000b005e4d8c6168csm7985460pff.210.2023.03.07.07.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 07:47:17 -0800 (PST)
Message-ID: <8a83ec79-be04-ec5c-f3ef-67f64dc55f12@acm.org>
Date:   Tue, 7 Mar 2023 07:47:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] scsi: ufs: core: Add trace event for MCQ
Content-Language: en-US
To:     Ziqi Chen <quic_ziqichen@quicinc.com>, quic_asutoshd@quicinc.com,
        quic_cang@quicinc.com, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <1677836154-29192-1-git-send-email-quic_ziqichen@quicinc.com>
 <67db2c6b-c3b0-c525-e6a9-2b2fe6c6adbb@acm.org>
 <f80fd91b-3a03-5c38-72c0-cd5c3edb33b8@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f80fd91b-3a03-5c38-72c0-cd5c3edb33b8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 21:53, Ziqi Chen wrote:
> You are right,  users may hate it if the trace events for legacy mode 
> and MCQ mode are different. But if I merge them into one event, it will 
> print much invalid information as we can not add if-else into TP_printk().
> 
> (For example:  in SDB legacy mode, you can see such invalid prints " 
> hqid = 0 , sqt= 0, cqh=0, cqt = 0")
> 
> Users may hate these invalid information.
> 
> Anyway, I have made new version that merge 2 mode into one event, but 
> are you sure we really need to use this way? if yes , I can push new 
> version here.
> 
> Or, could you give some suggestions if you have better way.
> 
> Below is a piece of new version code , you can preview.
> 
>      TP_fast_assign(
>          __assign_str(dev_name, dev_name);
>          __entry->str_t = str_t;
>          __entry->tag = tag;
>          __entry->doorbell = doorbell;
>          __entry->hwq_id = hwq? hwq->id: 0;
>          __entry->sq_tail = hwq? hwq->sq_tail_slot: 0;
>          __entry->cq_head = hwq? hwq->cq_head_slot: 0;
>          __entry->cq_tail = hwq? hwq->cq_tail_slot: 0;
>          __entry->transfer_len = transfer_len;
>          __entry->lba = lba;
>          __entry->intr = intr;
>          __entry->opcode = opcode;
>          __entry->group_id = group_id;
>      ),
> 
>      TP_printk(
>          "%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, 
> opcode: 0x%x (%s),"
>          "group_id: 0x%x, hqid: %d, sqt: %d, cqh: %d, cqt: %d",
>          show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name), 
> __entry->tag,
>          __entry->doorbell, __entry->transfer_len, __entry->intr, 
> __entry->lba,
>          (u32)__entry->opcode, str_opcode(__entry->opcode), 
> (u32)__entry->group_id,
>          __entry->hwq_id,__entry->sq_tail, __entry->cq_head,  
> __entry->cq_tail
>      )

Hi Ziqi,

Please reply below the original e-mail instead of above. This is 
expected on Linux kernel mailing lists.

Regarding your question: I propose to leave out the sq_tail, cq_head and 
cq_tail information. That information may be useful for hardware 
developers but is not useful for other users of the Linux kernel. So the 
only piece of information that is left that is MCQ-specific is the 
hardware queue index. I expect that users will be fine to see that 
information in trace events.

How about reporting hardware queue index -1 for legacy mode instead of 
0? That will allow users to tell the difference between legacy mode and 
MCQ mode from the trace events.

Thanks,

Bart.

