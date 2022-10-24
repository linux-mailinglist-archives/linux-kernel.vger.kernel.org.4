Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7692460C013
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJYAtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiJYAtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:49:00 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0A5BA26D;
        Mon, 24 Oct 2022 16:26:01 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id s22-20020a17090a075600b002130d2ad62aso3567158pje.2;
        Mon, 24 Oct 2022 16:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4tdyDrA1bdA8AvUPtQChZgerAt7IPUYG+zC2dp+joA=;
        b=u07O9SJVSLR7qRka8foGel9DT3sLUDddTNoa4O0FcHQZ++2HDt/FG9oqFmfyX1GFlW
         +GKWLKCPmx3JGiZ+ywQoayOOH47A8PcwGhWkMBaYDXQRp3oofsSxEm0A6yG621Umqx7U
         mi+sQko0eJHmw/fEjsaIxgCXP2VpdWXV2Lt4ntHqsIkofL9qKRoNo+e7P9QtztZTwHF2
         vw2ZhuctPJrUg5pnZ1Ava9JVBvOGfN1jLgxc2TagEsDKcD9Q2242Ya5QXtFYYwdcMlGh
         KgDJ8EGwZtVhi3Bwsrp71joUDZMbhHJGR0/9P11TS40PhSVnfx/7sc8IeknzRPVky4r2
         Jsyg==
X-Gm-Message-State: ACrzQf35hKQ7ORMqAUxxRxlPDJmY62YBdx2VpAkiWnlyiV4l97RkXsAR
        aeoc/EdclDaOk6kI9nXm3YM=
X-Google-Smtp-Source: AMsMyM5ISj2GugLn8OCErSEf/BC8Ne0xIDQZiV/2jTZrT+QyKUlr71AWi7Pe9giCoHTbDoOYHizOBw==
X-Received: by 2002:a17:902:ea10:b0:185:3d64:8d3f with SMTP id s16-20020a170902ea1000b001853d648d3fmr37259514plg.53.1666653961073;
        Mon, 24 Oct 2022 16:26:01 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id t17-20020a17090340d100b001869e17baf4sm229018pld.127.2022.10.24.16.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 16:26:00 -0700 (PDT)
Message-ID: <76dfbb5c-24f9-2a7c-b16e-692b32a42593@acm.org>
Date:   Mon, 24 Oct 2022 16:25:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/3] scsi: ufs: core: Revert "WB is only available on
 LUN #0 to #7"
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20221022213650.626766-1-beanhuo@iokpp.de>
 <20221022213650.626766-2-beanhuo@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221022213650.626766-2-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/22 14:36, Bean Huo wrote:
> One newer 'commit d3d9c4570285 ("scsi: ufs: Fix memory corruption by

One -> A?

> ufshcd_read_desc_param()")' has properly fixed stack overflow issue,
> 'commit a2fca52ee640 ("scsi: ufs: WB is only available on LUN #0 to #7")'
> is no longer required, we can revert it now.

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
