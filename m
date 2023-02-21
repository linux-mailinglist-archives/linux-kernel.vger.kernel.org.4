Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB57E69DD2C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjBUJtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjBUJtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:49:18 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFEF234CE;
        Tue, 21 Feb 2023 01:49:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id da10so15893136edb.3;
        Tue, 21 Feb 2023 01:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LdwNHcOx7nVwU4J/tHwSqkSY6cEaZO3K0e0TjSYhYbE=;
        b=CmYjc1Dfsm4QDGGVg2CCQ2jz+xbhUPMPSrwJF279Qa5iwEUlLXEl6NEasQP+oRUOGv
         uzXUzwjmVYBuZ9sGw7QXvC5Nquf4kVYYbjKojvg95uEzT6yXz4bHsHVuPkCt/VYSUQTx
         YS62yxEi0JRATc8vQZJ3S40kVYGT/cOiQvOlThVOPbJm6CnTS684oHomJtjbxTHgbcy2
         F+7//ju3mH263iDlBSTtvclZ+Fo5V0fcvFpmdPUzMZhJ3xXR3j/jOaXzH1vZpeKogpV2
         98EmrD10RVv7B20sCPTYxxSjzeuih93oiQ85n/ce0T/3YGqUL5QssNBpRmOSfLNyIwe1
         c0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdwNHcOx7nVwU4J/tHwSqkSY6cEaZO3K0e0TjSYhYbE=;
        b=IUwg2UtIMTJmtqKqkbpSwWH4JvEOc6MF6XeTUC+cY2qN/c/R3KXim9GNOl/ELF3Qj3
         +Ji4I4FtstjzwRlU+bvamrcqdX/IVWzZGBnYEe3yK2K/u0Qls9AhoVW05YYnT8Z+44iJ
         cYOOgbUcngeTPghK1Jh5xZYGvrN14fvYj/mRRmXgBhiCP5DCf69XEvRKXetQCzO6U2K/
         1RUT1jBN14gLC7oNyraUtR298ARGeMNDHuqhvHzT38Pqwe1m+fr2B5N0J4mlpkLzPsji
         iFF94NpLXgQ1kWJEsAyqoYGO3ViLjwPqIkc81TCyfMat648W0Ht/3XP18y8uIb9vfPBb
         z8Mg==
X-Gm-Message-State: AO0yUKUrMlSLmZ1gOrSSQcHNvrfDgBnRqUEQMdKaTNmqk7fzLTNiZ/e5
        KxnH/XHtAYwBDJsHaZXoFiY=
X-Google-Smtp-Source: AK7set/D2Hjs7e1kInqVeHI/rRZJX+swmXOevpfZmdGeCl4gAimvMAr8DmwYpWqToB9u1Z87l2+7zg==
X-Received: by 2002:a17:906:7ce:b0:895:58be:957 with SMTP id m14-20020a17090607ce00b0089558be0957mr10090551ejc.2.1676972953445;
        Tue, 21 Feb 2023 01:49:13 -0800 (PST)
Received: from [10.176.235.173] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id l13-20020a1709061c4d00b008dcb559dbdbsm1059214ejg.88.2023.02.21.01.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 01:49:12 -0800 (PST)
Message-ID: <614c6437-d0ba-a75f-8f65-6b47dab0ff99@gmail.com>
Date:   Tue, 21 Feb 2023 10:49:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] scsi: ufs: core: Add trace event for MCQ
Content-Language: en-US
To:     Ziqi Chen <quic_ziqichen@quicinc.com>, quic_asutoshd@quicinc.com,
        quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <1676959630-35504-1-git-send-email-quic_ziqichen@quicinc.com>
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <1676959630-35504-1-git-send-email-quic_ziqichen@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.23 7:07 AM, Ziqi Chen wrote:
> +
> +	TP_printk(
> +		"%s: %s: tag: %u, hwq_id: %d, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x, sq_tail_slot: %d, cq_head_slot: %d, cq_tail_slot: %d",

Hi Ziqi,

Looks good to me, just one thing,  the above print strings can be shortened?

hwq_id-->hdid
sq_tail_slot-->sqt
cq_tail_slot->sqt
cq_head_slot->cqh


Kind regards,
Bean

> +		show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
> +		__entry->tag, __entry->hwq_id, __entry->transfer_len,
> +		__entry->intr, __entry->lba, (u32)__entry->opcode,
> +		str_opcode(__entry->opcode), (u32)__entry->group_id,
> +		__entry->sq_tail, __entry->cq_head,  __entry->cq_tail
> +	)
