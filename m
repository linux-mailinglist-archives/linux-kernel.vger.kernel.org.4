Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9303A724A65
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbjFFRib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjFFRi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:38:29 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB910DE;
        Tue,  6 Jun 2023 10:38:28 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-bacf685150cso8044914276.3;
        Tue, 06 Jun 2023 10:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686073108; x=1688665108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jZZzUpN02JfdEi9qpDyIpAeWgU+U11uOqjPbUWV+z4=;
        b=Awzscidih9NOaFhCv0cGI/VX1NIMtFePaiEpZmyFv+mtGuHyXNXk8R25emzVsOzwZM
         YvGtYyjIt0oRw9MpFSLNd2h12CoFL1xAbO2PC3SczM2WP6HLBg3pTb47ZoWbI4qeiNdb
         jKc4W+RcG6AVBpWhyi3RNLjV1ZFbDPBdZarkfaD2Cp9h96pO50MYBfA0uIlFJ7dnasfn
         Wbo6UREshct7hBve61WVdQhbf9lCE0S9HlS/dtwNZQTHeI0kdM+kss0jPHqdvyjFsWNl
         yQKAlf+2VgIFafzk6PVYZmTyWN4lyvP9jN9EZg+eRHFTCT3j6kmDJGywFCm9t4erd8E0
         trBw==
X-Gm-Message-State: AC+VfDxbWOIud0ThWthzT69N2azze4c6Gj6GafQ+4GhYMFQK5fptJNFU
        9ORhX/GzJTT/VL9GQIhKb/A=
X-Google-Smtp-Source: ACHHUZ4bEOvgjkl+iBEBIndL9y9CH3erxgjvl5w+3hTt64XlcaBY418SZ1VZoiWjxsBK7SR/rFq0rA==
X-Received: by 2002:a25:7a86:0:b0:bb1:650c:8c04 with SMTP id v128-20020a257a86000000b00bb1650c8c04mr2706557ybc.56.1686073108054;
        Tue, 06 Jun 2023 10:38:28 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090a840c00b00253311d508esm9721400pjn.27.2023.06.06.10.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 10:38:27 -0700 (PDT)
Message-ID: <6ad5fba3-926a-7a23-b21b-abffd33708be@acm.org>
Date:   Tue, 6 Jun 2023 10:38:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] scsi: sd: support specify probe type of build-in driver
Content-Language: en-US
To:     Jianlin Lv <iecedge@gmail.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, paulmck@kernel.org, bp@suse.de,
        peterz@infradead.org, will@kernel.org, rdunlap@infradead.org,
        kim.phillips@amd.com, rostedt@goodmis.org, wyes.karny@amd.com
Cc:     jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20230606051217.2064-1-iecedge@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230606051217.2064-1-iecedge@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 22:12, Jianlin Lv wrote:
> In scenarios where SCSI disk name sensitivity is crucial, the probe type
> of the build-in sd driver can be set to synchronous. As a result,
> the scsi disk names are deterministic.

Which are these scenarios?

Additionally, how can synchronous scanning of sd devices make a 
difference if there are multiple host bus adapters that use an interface 
type that is scanned asynchronously?

Bart.
