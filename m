Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27B872DBD4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240834AbjFMIAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241101AbjFMH7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:59:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A34C3C16
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:58:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3d0b33dc2so11999465ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686643130; x=1689235130;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gFVICJk82rsLy6XURcItio5Wc3MLyUpCU3bKiLcn7E=;
        b=Zu1eNmH59rjQOm+08m4N17C7EGxZr54zmOO94OfKblpkr1l7peVqWXSNqS+0/kS6gX
         EapSF+QxF6DrIFV0TjB/67BzDJWIFcDgtaU/ji05c1C+S2c0li5WNJzs1zhq3oWZePi/
         79tD5grYYPpJSQ8nJ0OjlVgeckvPmJuUqsskvJq8iWb0tKMjp7scryD6wiMJQt4cTjYE
         oSBIajdSrEdw/p4rEGa1ntbbU7i+yBu7nBU+mXKzl8jn3CI5YTF+XvPARZTLAP3p0WyG
         vadttwCxVI6wTO6MtUsNikCSAdXyyEF62rloPdjiXb9y3SC3T+SQlU3i+rDRrlIs6E3P
         wTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686643130; x=1689235130;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8gFVICJk82rsLy6XURcItio5Wc3MLyUpCU3bKiLcn7E=;
        b=lagm5FIyouOHlKecevXKy+8GwmvGbCSC55dWuykEwZDVzPAtOOwfCLOKlbSHaLlcna
         IrtGCs0Y2HYsPVdtWZEFifdDudepkHijUNAc8vRtuNazfObWS4lwMXt0mZot+cpB84KY
         Z7zJUoLM/u1getlUqvtx7vw1ZV4LZbt+2eABmmVLzlFppKiOXbIUSwYiReDEbDB5btsf
         T3FUK3m/GziJIMVBBx32dPWGL2T8K3HfGgd3JRfzneFRf8WU+NAkHzgjA05jLNKM4r0Q
         cDk72Sccp1xgl3p5oDFdpg8B4LZD7PD6+FmIIUVST7eyUgUzw1buenQYJ5evWlEqHpeb
         tzzA==
X-Gm-Message-State: AC+VfDxWqDj2JBlSL95LcCRIe8TGRXGBCb8gJgIPJQbYsWU2nGVHHiok
        F9KvItRoN+ie6nfoztZLX4lWUaG4zYyFxQ==
X-Google-Smtp-Source: ACHHUZ4LF6u5/W4jCFiUuKAjF1AFewN+gLsPgJsbR4sHJpvM3DYDCzMRA98AOm63FAOSef1TdAzbog==
X-Received: by 2002:a17:902:b489:b0:1b3:7de7:f83f with SMTP id y9-20020a170902b48900b001b37de7f83fmr8268095plr.26.1686643130358;
        Tue, 13 Jun 2023 00:58:50 -0700 (PDT)
Received: from [183.173.18.203] ([183.173.18.203])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902869200b001b01fc7337csm9515480plo.247.2023.06.13.00.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:58:49 -0700 (PDT)
Message-ID: <32dc96d0-2d27-47e4-448a-a42e9ce352af@gmail.com>
Date:   Tue, 13 Jun 2023 15:58:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
From:   Tuo Li <islituo@gmail.com>
Subject: [BUG] ocfs2/dlm: possible data races in dlm_drop_lockres_ref_done()
 and dlm_get_lock_resource()
To:     mark@fasheh.com, jlbec@evilplan.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     ocfs2-devel@oss.oracle.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        baijiaju1990@outlook.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Our static analysis tool finds some possible data races in the OCFS2 file
system in Linux 6.4.0-rc6.

In most calling contexts, the variables  such as res->lockname.name and
res->owner are accessed with holding the lock res->spinlock. Here is an
example:

   lockres_seq_start() --> Line 539 in dlmdebug.c
     spin_lock(&res->spinlock); --> Line 574 in dlmdebug.c (Lock 
res->spinlock)
     dump_lockres(res, ...); --> Line 575 in fs/ocfs2/dlm/dlmdebug.c
       stringify_lockname(res->lockname.name, ...);  --> Line 493 in 
dlmdebug.c (Access res->lockname.name)
       scnprintf(..., res->owner, ...);  -->Line 498 in dlmdebug.c 
(Access res->owner)

However, in the following calling contexts:

   dlm_deref_lockres_worker() --> Line 2439 in dlmmaster.c
     dlm_drop_lockres_ref_done() --> Line 2459 in dlmmaster.c
       lockname = res->lockname.name; --> Line 2416 in dlmmaster.c 
(Access res->lockname.name)

   dlm_get_lock_resource() --> Line 701 in dlmmaster.c
     if (res->owner != dlm->node_num) --> Line 1023 in dlmmaster.c 
(Access res->owner)

The variables res->lockname.name and res->owner are accessed respectively
without holding the lock res->spinlock, and thus data races can occur.

I am not quite sure whether these possible data races are real and how 
to fix
them if they are real.

Any feedback would be appreciated, thanks!

Reported-by: BassCheck <bass@buaa.edu.cn>

Best wishes,
Tuo Li
