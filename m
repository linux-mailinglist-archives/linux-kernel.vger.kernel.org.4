Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7293E66409C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbjAJMf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbjAJMfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:35:16 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAAF3FA17
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:35:06 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso9768126wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/aHHqE6KgH9OX2A5zAtD00gsrEshF+2KG3l66IfnY8=;
        b=WVi5WPKefrgU2mn5lZGFM/ECyxq1Ew5j5egO+RHuunRLmez/SidFkV4KbN/wVFKvEw
         BYscOICtM7NGquev6ty857/39GVLm8QnkmiDWwvy3ltvezZJJ66qKVUASFlXxzWjbqd0
         kEL84OFPw/hDows113LHPIJ7VV2rGcCzO6/vjhXvJDNjcr7PGcHDvt4/2zm6BK9DH+So
         MLlo+Fu2aMtUZavsQqJjjKrn5P1lFW2hKHVV6ySfTSs1Ep0vbj1e+8X6DTkiKJ46Aah1
         ejT++0PbVdPUhGrenzH84bcUdeJlRaHZl3hqDkr9UVYvtKJnFOsYUeesO/DKxbnDitXh
         w2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/aHHqE6KgH9OX2A5zAtD00gsrEshF+2KG3l66IfnY8=;
        b=ski1OzeqDEaG39YYSNmkeRONEfQrXDagswO8d1Suvco5gskI+tHLkipwQJN2YWZV+V
         TuQfrrKIguEENYBHrjtoc8Ll1SApYwmbuh5oaCF9FSOZVRZ2ceoxtsCSzZluGHSsxiwo
         2KpSfXEz8RXCGyVTGwH/Cwk3CIg3P2goK+XJNw4g/SUE6InbUghLHAmeQsNYn3QDKbDA
         DQ59CIVz42SXfXuJcAjdEi1xjfcVIMcnji9kmUcl0Y7Omezw2yI0RIMwyggtQ3RIFdLv
         xUF8L6sItCAXcMEXN6RLMRL6RqpzBSZAxstGjD6ioO6ukm+eSqJJqXLqccQ6jQe1g0F5
         N6bQ==
X-Gm-Message-State: AFqh2kpjhL/gLvbOBxtDE7f1Wd5q2rEqkNvZx5I5xYqnfgAy23mj5caH
        01dzeZciMYwafFBclbEHvhujW6KRtVGp7Yy3L24=
X-Google-Smtp-Source: AMrXdXuJbnrbe1i5ZXRX7i8HSsqMJbBHwMiyWRHxvV9l+Uzo9fnn5oNza7LUitNXKtx2Zb0GovaWNA==
X-Received: by 2002:a05:600c:3b22:b0:3c6:e63e:814b with SMTP id m34-20020a05600c3b2200b003c6e63e814bmr48706261wms.2.1673354105125;
        Tue, 10 Jan 2023 04:35:05 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm20607777wmo.24.2023.01.10.04.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 04:35:04 -0800 (PST)
Message-ID: <19015168-c747-17b7-f0ae-9d2ee27d221c@linaro.org>
Date:   Tue, 10 Jan 2023 12:35:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To:     linux-kernel@vger.kernel.org, alexander@wetzel-home.de,
        johannes.berg@intel.com, Kalle Valo <kvalo@codeaurora.org>
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: ieee80211_handle_wake_tx_queue and dynamic ps regression
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a790cc3a4fad75048295571a350b95b87e022a5a 
(wake_tx_queue-broken-23-08-01)
Author: Alexander Wetzel <alexander@wetzel-home.de>
Date:   Sun Oct 9 18:30:39 2022 +0200

     wifi: mac80211: add wake_tx_queue callback to drivers

is causing a regression with

- CONF_PS = 1
- CONF_DYNAMIC_PS = 0
- ieee80211_handle_wake_tx_queue

In this case we get stuck in a loop similar to this

// IEEE80211_CONF_CHANGE_PS
[   17.255480] wcn36xx: wcn36xx_change_ps/312 enable
[   18.088835] ieee80211_tx_h_dynamic_ps/263 setting 
IEEE80211_QUEUE_STOP_REASON_PS
[   18.088906] ieee80211_handle_wake_tx_queue/334 entry
[   18.091505] ieee80211_dynamic_ps_disable_work/2250 calling 
ieee80211_hw_config()
[   18.095370] ieee80211_handle_wake_tx_queue/338 wake_tx_push_queue

// IEEE80211_CONF_CHANGE_PS
[   18.102625] wcn36xx: wcn36xx_change_ps/312 disable
[   18.107643] wake_tx_push_queue/303 entry

// txq is stopped here reason == IEEE80211_QUEUE_STOP_REASON_PS
[   18.107654] wake_tx_push_queue/311 q_stopped bitmask 0x00000002 
IEEE80211_QUEUE_STOP_REASON_PS true
[   18.107661] wake_tx_push_queue/324 exit
[   18.107667] ieee80211_handle_wake_tx_queue/342 exit
[   18.115560] ieee80211_handle_wake_tx_queue/334 entry
[   18.139937] ieee80211_handle_wake_tx_queue/338 wake_tx_push_queue
[   18.145163] wake_tx_push_queue/303 entry
[   18.150016] ieee80211_dynamic_ps_disable_work/2252 completed 
ieee80211_hw_config()

// now we unset IEEE80211_QUEUE_STOP_REASON_PS but too late
[   18.151145] wake_tx_push_queue/311 q_stopped bitmask 0x00000002 
IEEE80211_QUEUE_STOP_REASON_PS true
[   18.155263] ieee80211_dynamic_ps_disable_work/2254 clearing 
IEEE80211_QUEUE_STOP_REASON_PS
[   18.162531] wake_tx_push_queue/324 exit
[   18.162548] ieee80211_handle_wake_tx_queue/342 exit
[   18.183639] ieee80211_dynamic_ps_disable_work/2259 cleared 
IEEE80211_QUEUE_STOP_REASON_PS

// IEEE80211_CONF_CHANGE_PS runs again
[   18.215487] wcn36xx: wcn36xx_change_ps/312 enable

We get stuck in that loop. Packets getting transmitted is a rare event, 
most are dropped.

I tried this as a fix

--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2245,15 +2245,15 @@ void ieee80211_dynamic_ps_disable_work(struct 
work_struct *work)
                 container_of(work, struct ieee80211_local,
                              dynamic_ps_disable_work);

-       if (local->hw.conf.flags & IEEE80211_CONF_PS) {
-               local->hw.conf.flags &= ~IEEE80211_CONF_PS;
-               ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
-       }
-
         ieee80211_wake_queues_by_reason(&local->hw,
                                         IEEE80211_MAX_QUEUE_MAP,
                                         IEEE80211_QUEUE_STOP_REASON_PS,
                                         false);
+
+       if (local->hw.conf.flags & IEEE80211_CONF_PS) {
+               local->hw.conf.flags &= ~IEEE80211_CONF_PS;
+               ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
+       }
  }

but it only "slightly improves" the situation, the fundamental race 
condition is still there.

Suggest reverting this change and trying again.

---
bod
