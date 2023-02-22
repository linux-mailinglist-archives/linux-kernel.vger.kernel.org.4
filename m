Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA55369FC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjBVT1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjBVT1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:27:22 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131642BE1;
        Wed, 22 Feb 2023 11:27:11 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ee7so19724714edb.2;
        Wed, 22 Feb 2023 11:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BID4JJ8IOt4uoscGl3Tvw5E8rY69KG0XJZYadxF7Prc=;
        b=mffGYhSB6TDRuyjKlDeTJLVPCgQaa9RLk1n45FXEOEz++TEqSiOsqVWDwa3YhzYrpg
         O1T131tHBUPAkniowWSaPE0zIgLRqy4GoF0rC7MqSJvLjIQCVe8kGVVA15Msay8yagpb
         qsG31BJXBSb3lGG4lS3ez64wVvkVWSqIGdHxkjHOWy26+d/WLS0X1wHrUkKpMH9L+sLQ
         QXLY7BoPUhOwk+szsnjyy6tLg6JyM7xCPpvZAEBX/9ZzjlxAbKCux/Og4gnRp68FzUO3
         cOCsjaHcFj+cqbujf44LIlJ47uhQH90pJhdNQl5NFql08i6gsvaSS3X5aX1BNcNEilHi
         e1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BID4JJ8IOt4uoscGl3Tvw5E8rY69KG0XJZYadxF7Prc=;
        b=GqcPpN4UKJAehiictalbeWwL89J0ozn6oL4mhGCwpILDAAwACO9MInPuLvsXDz98aI
         vISrcHBO5TInbkZ5DkCqqpDbUaYKwQUs/HwYAhBXkaOmeIDN11WVmlf9XkDS/8UqyFk1
         4ZhqwPA1WVyzKP87IF5ZYqarCbxkMYyanVBDy3IbqI8KKnXdYJ7ruBO+mDrzGUT/qq5A
         7e1TaOhWrpj0lI571b+KE8m6r3TQVFwO6YxPDJ9yOB3jWv5smAeHqZT3DG5bPkyS0pes
         /bFhfyO5Ae0sJo88GqSVsCei89lp0/7AcGiUA/EJZ5cI+3A8JhH94AV1ng+MShby8XU2
         ST6g==
X-Gm-Message-State: AO0yUKWf6RWuz9OZmgAhtiG9KEqnqiakYIMgJ3i1WHL5Q1k6PJaWqIwu
        Mz75tsikt7EAnvxUKvrOp04=
X-Google-Smtp-Source: AK7set8bjdvm6sV4wRZt+pB17xKkGIBJ9jaZSLUev4xQ8ofWafVr3GNWHxa2I1EwvVNKJWoCOelouQ==
X-Received: by 2002:a17:907:7e84:b0:8e9:6f9f:7c2d with SMTP id qb4-20020a1709077e8400b008e96f9f7c2dmr2583212ejc.35.1677094029810;
        Wed, 22 Feb 2023 11:27:09 -0800 (PST)
Received: from [10.176.235.173] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id ca5-20020a170906a3c500b008c1952b63d8sm5928220ejb.137.2023.02.22.11.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 11:27:09 -0800 (PST)
Message-ID: <2c2b803d-ffd6-6583-ddf9-aefb0bc51e8d@gmail.com>
Date:   Wed, 22 Feb 2023 20:27:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] scsi: ufs: core: Add trace event for MCQ
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
References: <1677051569-81113-1-git-send-email-quic_ziqichen@quicinc.com>
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <1677051569-81113-1-git-send-email-quic_ziqichen@quicinc.com>
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


On 22.02.23 8:39 AM, Ziqi Chen wrote:
> Added a new trace event to record MCQ relevant information
> for each request in MCQ mode, include hardware queue ID,
> SQ tail slot, CQ head slot and CQ tail slot.
>
> Signed-off-by: Ziqi Chen<quic_ziqichen@quicinc.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
