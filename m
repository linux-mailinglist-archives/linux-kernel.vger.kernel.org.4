Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C9E6F0434
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbjD0K2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243288AbjD0K2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:28:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DE55256;
        Thu, 27 Apr 2023 03:28:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so45264865e9.1;
        Thu, 27 Apr 2023 03:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682591317; x=1685183317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsPS+00a1dZLp9LSK0ZrosYCd65h9Kmfa6gKaFuspLg=;
        b=Vh38b6dKEuPyG3hnP0eVquMuo1sN8FuMyytdNkN9RbQcdCtI9gPDEp5I2CoZh4Fa+d
         xU+NGZEGqMjNkiZWG0nel5FG2W2qJTT/j3u4iNA1jftt4GQf4A/4C/XZNb6t/8Eremd1
         P4reS4Iv/yAkPtUGkAauZhR0tFMLHFcj3rEigbG9NIl87PMgUJMEtIqei91UMtKOXvpc
         SF8OTmQZfpwYONyg2w59DvlQSEbuo6LBK9zbTpz3PnIxu0fikmDt3/TH3Qd6bpFsbpsY
         pxiTKmy5DmuVDlrdIypbr9HaOj13EQONMThV8liRSNewYG+YLi1AzhDc1YYAevZKUtHM
         PIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682591317; x=1685183317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsPS+00a1dZLp9LSK0ZrosYCd65h9Kmfa6gKaFuspLg=;
        b=gl6QkA1iphEPbHRWcH9Yg4xCQU8yq/0nPjCCXEEZgpQ3kcBNY+ckOKeDrwOXJyn84W
         wfsvmSZebh7+2dD/liBJu7MQRplTSdoAXxpFH+jNSvwaaPxvtugBIVXtv8rORb08cNnP
         k86CxzAjCFzjorGxHqXxyB0R+/HzTyAWFPPmuh28XSBGiuwcihK7DxERNM0hs9WCBDnj
         BsIIwrClmogQpt6NLb8CpR0M8VEP9kYotxO6ceLL98h9UtEXszlYvgrI6CNhnpYqUMOU
         1gJKOE7JrC1ajs+OLIAVOhmxXzdc7GfZBKnawhPan6CGgXr9gHtNsm3AEXeXhFQfycEK
         FSPQ==
X-Gm-Message-State: AC+VfDz2aJASeo1RkWtFdj/ERR0qB8tg6Pkh8b/9A7H3Ln/B5gQoscSq
        39NikQRWmzXOzEGfr/F228hQEsinZ4RHZg==
X-Google-Smtp-Source: ACHHUZ4iqn612iYgzA3sjBKudq7RLAA6AxGrlYD98j6R3/4n4VFELHkz3cFfxBee61Bigh43AGH+vw==
X-Received: by 2002:a7b:c015:0:b0:3f1:662a:93d0 with SMTP id c21-20020a7bc015000000b003f1662a93d0mr1123452wmb.15.1682591317134;
        Thu, 27 Apr 2023 03:28:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z16-20020a05600c221000b003ee1b2ab9a0sm20790097wml.11.2023.04.27.03.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:28:36 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/spelling.txt: add more spellings to spelling.txt
Date:   Thu, 27 Apr 2023 11:28:35 +0100
Message-Id: <20230427102835.83482-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the more common spelling mistakes and typos that I've found while
fixing up spelling mistakes in the kernel over the past couple of releases.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 scripts/spelling.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index f8bd6178d17b..fc7ba95e86a0 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -155,6 +155,7 @@ aquired||acquired
 aquisition||acquisition
 arbitary||arbitrary
 architechture||architecture
+archtecture||architecture
 arguement||argument
 arguements||arguments
 arithmatic||arithmetic
@@ -279,6 +280,7 @@ cant'||can't
 canot||cannot
 cann't||can't
 cannnot||cannot
+capabiity||capability
 capabilites||capabilities
 capabilties||capabilities
 capabilty||capability
@@ -426,6 +428,7 @@ cotrol||control
 cound||could
 couter||counter
 coutner||counter
+creationg||creating
 cryptocraphic||cryptographic
 cummulative||cumulative
 cunter||counter
@@ -492,6 +495,7 @@ destorys||destroys
 destroied||destroyed
 detabase||database
 deteced||detected
+detecion||detection
 detectt||detect
 detroyed||destroyed
 develope||develop
@@ -513,6 +517,7 @@ diferent||different
 differrence||difference
 diffrent||different
 differenciate||differentiate
+diffreential||differential
 diffrentiate||differentiate
 difinition||definition
 digial||digital
@@ -617,6 +622,7 @@ evalute||evaluate
 evalutes||evaluates
 evalution||evaluation
 excecutable||executable
+excceed||exceed
 exceded||exceeded
 exceds||exceeds
 exceeed||exceed
@@ -632,6 +638,7 @@ existant||existent
 exixt||exist
 exsits||exists
 exlcude||exclude
+exlcuding||excluding
 exlcusive||exclusive
 exlusive||exclusive
 exmaple||example
@@ -726,6 +733,8 @@ generiously||generously
 genereate||generate
 genereted||generated
 genric||generic
+gerenal||general
+geting||getting
 globel||global
 grabing||grabbing
 grahical||graphical
@@ -899,6 +908,7 @@ iteraions||iterations
 iternations||iterations
 itertation||iteration
 itslef||itself
+ivalid||invalid
 jave||java
 jeffies||jiffies
 jumpimng||jumping
@@ -977,6 +987,7 @@ microprocesspr||microprocessor
 migrateable||migratable
 millenium||millennium
 milliseonds||milliseconds
+minimim||minimum
 minium||minimum
 minimam||minimum
 minimun||minimum
@@ -1042,6 +1053,7 @@ notifed||notified
 notity||notify
 nubmer||number
 numebr||number
+numer||number
 numner||number
 nunber||number
 obtaion||obtain
@@ -1061,6 +1073,7 @@ offet||offset
 offlaod||offload
 offloded||offloaded
 offseting||offsetting
+oflload||offload
 omited||omitted
 omiting||omitting
 omitt||omit
@@ -1105,6 +1118,7 @@ pakage||package
 paket||packet
 pallette||palette
 paln||plan
+palne||plane
 paramameters||parameters
 paramaters||parameters
 paramater||parameter
@@ -1181,12 +1195,14 @@ previsously||previously
 primative||primitive
 princliple||principle
 priorty||priority
+priting||printing
 privilaged||privileged
 privilage||privilege
 priviledge||privilege
 priviledges||privileges
 privleges||privileges
 probaly||probably
+probabalistic||probabilistic
 procceed||proceed
 proccesors||processors
 procesed||processed
@@ -1460,6 +1476,7 @@ submited||submitted
 submition||submission
 succeded||succeeded
 suceed||succeed
+succesfuly||successfully
 succesfully||successfully
 succesful||successful
 successed||succeeded
@@ -1503,6 +1520,7 @@ symetric||symmetric
 synax||syntax
 synchonized||synchronized
 sychronization||synchronization
+sychronously||synchronously
 synchronuously||synchronously
 syncronize||synchronize
 syncronized||synchronized
@@ -1532,6 +1550,7 @@ threee||three
 threshhold||threshold
 thresold||threshold
 throught||through
+tansition||transition
 trackling||tracking
 troughput||throughput
 trys||tries
@@ -1611,6 +1630,7 @@ unneccessary||unnecessary
 unnecesary||unnecessary
 unneedingly||unnecessarily
 unnsupported||unsupported
+unuspported||unsupported
 unmached||unmatched
 unprecise||imprecise
 unpriviledged||unprivileged
@@ -1657,6 +1677,7 @@ verfication||verification
 veriosn||version
 verisons||versions
 verison||version
+veritical||vertical
 verson||version
 vicefersa||vice-versa
 virtal||virtual
@@ -1677,6 +1698,7 @@ whenver||whenever
 wheter||whether
 whe||when
 wierd||weird
+wihout||without
 wiil||will
 wirte||write
 withing||within
-- 
2.30.2

