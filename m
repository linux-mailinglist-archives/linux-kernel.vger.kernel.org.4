Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6913E699B75
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjBPRoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBPRoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:44:22 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960644FAA1;
        Thu, 16 Feb 2023 09:44:14 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id e17so2784268plg.12;
        Thu, 16 Feb 2023 09:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNlyHVO03gSSlxY11fMP/YX0lFTvzCZ7sRSjwx4TdKQ=;
        b=yqZv3NcUCwSiOcow8KL07wltxQaZBh+z7JFJV982GB1bQbJzW3FjQBfEdJMb1poQOq
         kMva7RPTd6h8BcBTVwjzloOrjd55aV7T0ccjWjAbJXtmAgILGn1fZX4FzxQynIk2asU7
         RD1633+GqTlZhjW8Rx0QqeDCMUQF6KkwCNRcs1dDIPLEM8K/4h/puFCWHqe/+IYb/bIF
         dyKNDqdYcGc0m5PHKeGYF6KiiDEUET1oaGnWCaywBaQnGHwnic440+6tOr/iQnMZI63i
         M5J1EARBoyXGh3SQh3h7IMjr3P/Wrpapfx98pOD+jYNA2NiNxfaPFNUAmflZDIltVBkx
         jXeA==
X-Gm-Message-State: AO0yUKUrWRc3/zFcAfIgupa7BDqulZ7xz0a9gOrAfzXZGF74bW2hvLpF
        fDmMMlL3KOel7ShCRAIxWpY=
X-Google-Smtp-Source: AK7set9dQjUa26lRSSatffjWGkjyIjtK9E0mv/mmiA047bV64RNBvX+Cf8+JcyzB6Rqbn4D+OGRlIw==
X-Received: by 2002:a17:902:e2c2:b0:19a:8304:21f1 with SMTP id l2-20020a170902e2c200b0019a830421f1mr4896457plc.69.1676569454020;
        Thu, 16 Feb 2023 09:44:14 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:3a83:c047:6e5d:a776? ([2620:15c:211:201:3a83:c047:6e5d:a776])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902aa4400b0019a7ef5e9a8sm1595198plr.82.2023.02.16.09.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 09:44:13 -0800 (PST)
Message-ID: <e318febd-8731-3289-e168-d566db82a5b2@acm.org>
Date:   Thu, 16 Feb 2023 09:44:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1] scsi: ufs: core: Add trace event for MCQ
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
References: <1676515562-55805-1-git-send-email-quic_ziqichen@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1676515562-55805-1-git-send-email-quic_ziqichen@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 18:45, Ziqi Chen wrote:
> diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
> index 599739e..a406404e 100644
> --- a/include/trace/events/ufs.h
> +++ b/include/trace/events/ufs.h
> @@ -10,6 +10,7 @@
>   #define _TRACE_UFS_H
>   
>   #include <linux/tracepoint.h>
> +#include <ufs/ufshcd.h>

Would including <ufs/ufs.h> here be sufficient?

Thanks,

Bart.

