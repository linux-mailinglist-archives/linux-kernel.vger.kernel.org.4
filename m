Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F946A9E16
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjCCSBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjCCSBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:01:42 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BEF5C101;
        Fri,  3 Mar 2023 10:01:42 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id x34so3431893pjj.0;
        Fri, 03 Mar 2023 10:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677866501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWGuyBa/K9kl/YKy3i+8MdvYGygGQlay2p5yZc2a0D0=;
        b=z+HNmp/iezbHpAt0aRQ7gPI8RGPdmRysZ7DufM8iATcjMWndkRkQXox7g512g5AXep
         TlcsPnOJ9lRIhKGCSsx/vZYhoHo8CqjzQwwjNheyAh3QEMK2df3IYis9mLOUpwiPuxWr
         dXrRtvnBE5MjHXV6e/bOtkiFbwQEJOc81yngSAigvXv2ArwuXzkDzm7rKFxKCulYulRH
         bf1BoPwdjehGmOEaPdq/ezgV2CuFrvaYEwNsEaCdM4NneVjJss2V3t98TM1mO0+hM0W/
         QgHkqZ03XTFVu2Rl2lXyTg4EB84l3VAklp3szDDOLUiVX8XS7R2BMHx1LpJoi2NQOf3n
         7Ijw==
X-Gm-Message-State: AO0yUKUc9TKPb0N7WFlMBhEX1ajHywoFPtn1BPxIL1KUquOhpaNx/GXO
        B7KDC+bT1G6elI53B7PU7gM=
X-Google-Smtp-Source: AK7set8inIdY943yP2v0aKe33V3AWcq8Jl6Fy5mEBuRrcJmAzPBMj1B6BPldlM18ETchZ18MbaDK6A==
X-Received: by 2002:a17:903:1103:b0:19e:8075:5545 with SMTP id n3-20020a170903110300b0019e80755545mr3342032plh.54.1677866501516;
        Fri, 03 Mar 2023 10:01:41 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:30f3:595a:48e5:cb41? ([2620:15c:211:201:30f3:595a:48e5:cb41])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b00186b69157ecsm1770403plo.202.2023.03.03.10.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 10:01:40 -0800 (PST)
Message-ID: <67db2c6b-c3b0-c525-e6a9-2b2fe6c6adbb@acm.org>
Date:   Fri, 3 Mar 2023 10:01:38 -0800
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1677836154-29192-1-git-send-email-quic_ziqichen@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/23 01:35, Ziqi Chen wrote:
> -	doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
> -	trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
> -			doorbell, transfer_len, intr, lba, opcode, group_id);
> +
> +	if (is_mcq_enabled(hba)) {
> +		hwq = ufshcd_mcq_req_to_hwq(hba, rq);
> +		trace_ufshcd_command_mcq(dev_name(hba->dev), str_t, tag,
> +				hwq, transfer_len, intr, lba, opcode, group_id);
> +	} else {
> +		doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
> +		trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
> +				doorbell, transfer_len, intr, lba, opcode, group_id);
> +	}
>   }
Users will hate it if the trace events for legacy mode and MCQ mode are 
different. Instead of defining a new trace event for the MCQ mode, I 
think we need to add the MCQ information in the existing trace event.

Thanks,

Bart.
