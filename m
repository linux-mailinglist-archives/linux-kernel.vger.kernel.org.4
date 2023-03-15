Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9E6BB8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjCOP5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjCOP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:57:20 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D760D66;
        Wed, 15 Mar 2023 08:56:54 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so2518520pjg.4;
        Wed, 15 Mar 2023 08:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678895789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLyRa659ppZfr00XgXbmuzNUZ7mOL5EaQxAMAj2ecCE=;
        b=UA1AJwe7Lud1kXe08YqG6yOUT0nCebGYXcouW/0KHeMxoJKkwBuXbd1rKymFYXeyME
         iD9rj5poFmkiLOLgW70M1ZFlEDU711C2x+JP33zfWUca4O0rr5DQtMaWuRL9Wd7ScguA
         lOYnF7MixFOCIKa2FQ/xfBT5G2NClLxH6lqkBlPn9G3SDKOaAY6OHuDOza8SkZET2jg4
         S58wdMl2f2EgjSb4rQPE7o4eNF0Dy2MxBLtNcmZtHRS3+R+yVn/odXGAmWHHR08Hi/Lr
         r59XEpioNasp38yV3J9e3DFAwgCOqAcF/7YS08fSOdqebr5z6Vp/obB+vYks9P4lra5S
         cGOg==
X-Gm-Message-State: AO0yUKWk6IClywsQstkD9Q5ZFfANSp18VEcAOoKt+VFWYwAMzRx9cFzY
        iMbRUHlaPeoUD4zsZrRaM30=
X-Google-Smtp-Source: AK7set/0V5JL2LKWGKw+Y/5UKZF8d55Rr6cupu0hHWB4V3dlqgHhnpvW/wPfEywuY4yoTqrjeFkO7w==
X-Received: by 2002:a17:90b:3ec5:b0:23b:50ff:59ba with SMTP id rm5-20020a17090b3ec500b0023b50ff59bamr251840pjb.21.1678895789629;
        Wed, 15 Mar 2023 08:56:29 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:558a:e74:a7b9:2212? ([2620:15c:211:201:558a:e74:a7b9:2212])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902ed0b00b0019e81c8fd01sm3810169pld.249.2023.03.15.08.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 08:56:29 -0700 (PDT)
Message-ID: <0aa8141d-52e2-de27-7805-71395c01f015@acm.org>
Date:   Wed, 15 Mar 2023 08:56:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7] scsi: ufs: core: Add trace event for MCQ
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
References: <1678866271-49601-1-git-send-email-quic_ziqichen@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1678866271-49601-1-git-send-email-quic_ziqichen@quicinc.com>
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

On 3/15/23 00:44, Ziqi Chen wrote:
> Add MCQ hardware queue ID in the existing trace event
> ufshcd_command().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
