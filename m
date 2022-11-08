Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01509620E36
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiKHLHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiKHLHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:07:23 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7637A4C276;
        Tue,  8 Nov 2022 03:07:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso11455277wma.1;
        Tue, 08 Nov 2022 03:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=98jIYeZdzwnjQ1OI8X0J7FIBv+q8e16tsVy9J0FmYyk=;
        b=Q5lNwxqgivlQqy2QM0as6XlTHGACHXqkfSzUGoFoA3QoOOR6yI6W5AOTSKX7GPi8YZ
         0vgr78NL/qbsyn5LUgw23Pnr/VVFUJZBjn2RnbLkstlj3Ij/Ma0IExyuaKmi9Zu82TG7
         blki+Soh9YBTuixT5B20BEQFnXsjY1z+8mD2Fk7l9Vo+T/Hsy9UgUKRjyv4rjxzWsNoK
         2BxqLWcy62dgVxtzxh4YZNtJ9Rxr4QSOD6M6xO5n4eu/0JPXk8p5bv2B+V3Zq7Tbf39E
         VBiDgwada4hR2O8NFteFgp2sebgX+Tdv38XBE3BgsCY0kesvQ+aUKT2kBY7QqXqhycvH
         J77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98jIYeZdzwnjQ1OI8X0J7FIBv+q8e16tsVy9J0FmYyk=;
        b=4mvxmltMmYo6v7+GWihLL7SWFRpT2Vgi0V9uf1D8GvNZwsvYDWIe8tYtMdUYXc8mTD
         GO3tA8ZrlhDi0Wd9/lpfo6gWa3IlKQJWkWnisqWjPeXxEs3yEYtP9HlQlbeyAIVyzLZj
         z/DwtgbCyoFjvImY1XETnqtL0Fv1Bm7D5wpfwpSKKNI38ZugujKWqmhUDPCoYpk1KooL
         yP/tI4SpEwlFOHeNc++/00HQENQrUUxyCxPpsnHWWJDu/4fo81gRchJYVGNeQxzgVJVV
         r7xC4ydTMt8G/ecoa70Difyp4CNGXrWx9uHqhuUO6IcOO0iB0iWA/2V9FcUIz6NiqH62
         FpYQ==
X-Gm-Message-State: ACrzQf2jYy25MwI8ccq2aP7IpwUoAcPmUZaf2h4q6LU4dcCKaLXOKGXf
        xqs0Mw12CMQXrw4Sk5fCqgc=
X-Google-Smtp-Source: AMsMyM6jGFz0OUD6hCAKx8/CKR8MVaQ76lnfuPnUBbdOOZtAP9PJE6p1F8V6HXrNPOed22TVlpWnCg==
X-Received: by 2002:a05:600c:4448:b0:3c6:fb65:2497 with SMTP id v8-20020a05600c444800b003c6fb652497mr46697657wmn.124.1667905633883;
        Tue, 08 Nov 2022 03:07:13 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j27-20020a05600c1c1b00b003a8434530bbsm15399867wms.13.2022.11.08.03.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 03:07:13 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/spelling.txt: add more spellings to spelling.txt
Date:   Tue,  8 Nov 2022 11:07:12 +0000
Message-Id: <20221108110712.114611-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the more common spelling mistakes and typos that I've found
while fixing up spelling mistakes in the kernel in the past year.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 scripts/spelling.txt | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 8435b99452b6..ded8bcfc0247 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -23,6 +23,7 @@ absoulte||absolute
 acccess||access
 acceess||access
 accelaration||acceleration
+accelearion||acceleration
 acceleratoin||acceleration
 accelleration||acceleration
 accesing||accessing
@@ -58,6 +59,7 @@ acording||according
 activete||activate
 actived||activated
 actualy||actually
+actvie||active
 acumulating||accumulating
 acumulative||accumulative
 acumulator||accumulator
@@ -253,6 +255,7 @@ brigde||bridge
 broadcase||broadcast
 broadcat||broadcast
 bufer||buffer
+bufferred||buffered
 bufufer||buffer
 cacluated||calculated
 caculate||calculate
@@ -273,6 +276,7 @@ cant||can't
 cant'||can't
 canot||cannot
 cann't||can't
+cannnot||cannot
 capabilites||capabilities
 capabilties||capabilities
 capabilty||capability
@@ -309,6 +313,7 @@ chiled||child
 chked||checked
 chnage||change
 chnages||changes
+chnange||change
 chnnel||channel
 choosen||chosen
 chouse||chose
@@ -439,6 +444,7 @@ defferred||deferred
 definate||definite
 definately||definitely
 definiation||definition
+definiton||definition
 defintion||definition
 defintions||definitions
 defualt||default
@@ -452,6 +458,7 @@ delare||declare
 delares||declares
 delaring||declaring
 delemiter||delimiter
+delibrately||deliberately
 delievered||delivered
 demodualtor||demodulator
 demension||dimension
@@ -481,6 +488,7 @@ destroied||destroyed
 detabase||database
 deteced||detected
 detectt||detect
+detroyed||destroyed
 develope||develop
 developement||development
 developped||developed
@@ -507,6 +515,7 @@ dimention||dimension
 dimesions||dimensions
 diconnected||disconnected
 disabed||disabled
+disasembler||disassembler
 disble||disable
 disgest||digest
 disired||desired
@@ -666,6 +675,7 @@ finanize||finalize
 findn||find
 finilizes||finalizes
 finsih||finish
+fliter||filter
 flusing||flushing
 folloing||following
 followign||following
@@ -725,6 +735,7 @@ hanled||handled
 happend||happened
 hardare||hardware
 harware||hardware
+hardward||hardware
 havind||having
 heirarchically||hierarchically
 heirarchy||hierarchy
@@ -740,6 +751,7 @@ howver||however
 hsould||should
 hypervior||hypervisor
 hypter||hyper
+idel||idle
 identidier||identifier
 iligal||illegal
 illigal||illegal
@@ -931,9 +943,11 @@ matchs||matches
 mathimatical||mathematical
 mathimatic||mathematic
 mathimatics||mathematics
+maxmium||maximum
 maximium||maximum
 maxium||maximum
 mechamism||mechanism
+mechanim||mechanism
 meetign||meeting
 memeory||memory
 memmber||member
@@ -942,6 +956,7 @@ memroy||memory
 ment||meant
 mergable||mergeable
 mesage||message
+mesages||messages
 messags||messages
 messgaes||messages
 messsage||message
@@ -983,8 +998,9 @@ monochromo||monochrome
 monocrome||monochrome
 mopdule||module
 mroe||more
-multipler||multiplier
 mulitplied||multiplied
+muliple||multiple
+multipler||multiplier
 multidimensionnal||multidimensional
 multipe||multiple
 multple||multiple
@@ -1109,6 +1125,7 @@ peroid||period
 persistance||persistence
 persistant||persistent
 phoneticly||phonetically
+plaform||platform
 plalform||platform
 platfoem||platform
 platfrom||platform
@@ -1236,6 +1253,7 @@ refering||referring
 refernces||references
 refernnce||reference
 refrence||reference
+regiser||register
 registed||registered
 registerd||registered
 registeration||registration
@@ -1276,6 +1294,7 @@ reseting||resetting
 reseved||reserved
 reseverd||reserved
 resizeable||resizable
+resotre||restore
 resouce||resource
 resouces||resources
 resoures||resources
@@ -1314,6 +1333,7 @@ runtine||runtime
 sacrifying||sacrificing
 safly||safely
 safty||safety
+satify||satisfy
 savable||saveable
 scaleing||scaling
 scaned||scanned
@@ -1365,10 +1385,12 @@ similiar||similar
 simlar||similar
 simliar||similar
 simpified||simplified
+simultaneusly||simultaneously
 simultanous||simultaneous
 singaled||signaled
 singal||signal
 singed||signed
+slect||select
 sleeped||slept
 sliped||slipped
 softwade||software
@@ -1438,6 +1460,7 @@ suported||supported
 suport||support
 supportet||supported
 suppored||supported
+supporing||supporting
 supportin||supporting
 suppoted||supported
 suppported||supported
@@ -1475,15 +1498,18 @@ sytem||system
 sythesis||synthesis
 taht||that
 tained||tainted
+tarffic||traffic
 tansmit||transmit
 targetted||targeted
 targetting||targeting
 taskelt||tasklet
 teh||the
+temeprature||temperature
 temorary||temporary
 temproarily||temporarily
 temperture||temperature
 thead||thread
+theads||threads
 therfore||therefore
 thier||their
 threds||threads
@@ -1533,12 +1559,14 @@ ture||true
 tyep||type
 udpate||update
 uesd||used
+unknwon||unknown
 uknown||unknown
 usccess||success
 uncommited||uncommitted
 uncompatible||incompatible
 unconditionaly||unconditionally
 undeflow||underflow
+undelying||underlying
 underun||underrun
 unecessary||unnecessary
 unexecpted||unexpected
@@ -1569,11 +1597,14 @@ unneedingly||unnecessarily
 unnsupported||unsupported
 unmached||unmatched
 unprecise||imprecise
+unpriviledged||unprivileged
+unpriviliged||unprivileged
 unregester||unregister
 unresgister||unregister
 unrgesiter||unregister
 unsinged||unsigned
 unstabel||unstable
+unsolicted||unsolicited
 unsolicitied||unsolicited
 unsuccessfull||unsuccessful
 unsuported||unsupported
-- 
2.38.1

