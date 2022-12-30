Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE70265990E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiL3Nve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiL3Nu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:50:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2644EE0E;
        Fri, 30 Dec 2022 05:50:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id fy4so22394057pjb.0;
        Fri, 30 Dec 2022 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AfeuljETMDUgPPbrwTbLySPR/cbksFJWNX7W4kX5JM=;
        b=J597vT6vhaSDd4vCZaraJ8cvBmp8WX0JSQgHi7aSRcZ57ijFVHicButvWKPDFn/Qr6
         7ZOvc7PA0C/ZBo1y8Qz42EjEol2RLF1QjSAlfLrpMZ7tdfpmLFWB7cERhzM2m26WtK8R
         3RbzTyS0/xGpXnYtnFMlbLYR8E1cPxUPjk+kzw3iUyycS14UR40X4j4iSRMFi/Jsv5e7
         l6fSZTepHRfvPaOfUuqkiQEgEMxNwj/w4ZbKYNQp5K41e/1mP66a8Icx68leErLuGUfy
         RgcgGlEJ/y5eEn/LCcW4vS+imrXoZIIvKmZ685jGdarD4/+GADJzH/Ca+/buIJkVSFJe
         My4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AfeuljETMDUgPPbrwTbLySPR/cbksFJWNX7W4kX5JM=;
        b=jwcDV93VQeg1GaNwlCw6z7VJEsx43dRPUnkuDim9C2qAyzZRcZCeKAduok46qWpb9a
         T+V5FgZtiR5GI6mF9ZPiZpTcHM/orNdbobsIiHgJVbHNlwSb9pFTTTgmRoMLNxj+iA73
         NdQmuCg+buYXETlxahXMr7NKq3Z9rElNvgO3s8r1rpdUThZAPge5p21pGJrVh6W2J328
         4G/oOQ6Ve7J4G8wL6KCUmrS9chF46IkI61N1v2VmGdpe3Tr6FPRyncur6zrYjscHQ/SU
         5f7zc8rHW1g3eDg6UzwO7Qh+D5PZTH2FMWNAP0ALs6C4jAcNwWHsgc2K9qxtrE6icTEP
         GmyA==
X-Gm-Message-State: AFqh2krLMy6JXZ5yW0jEeRbGkq2aUHTkf/X+R7C4JPqxhNmPGHSmLRES
        j61i1oXz4wWMTU0ZaP0oZgg=
X-Google-Smtp-Source: AMrXdXv4Xqrw76sAxYeGOKudDkN2Ffdd26WUsHygJXEsgs5JzPnno/o2FroyslYnYkaPyoBeYLZ+2g==
X-Received: by 2002:a05:6a20:6a91:b0:ad:5a4d:95b5 with SMTP id bi17-20020a056a206a9100b000ad5a4d95b5mr51509674pzb.40.1672408256244;
        Fri, 30 Dec 2022 05:50:56 -0800 (PST)
Received: from debian.me (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id y136-20020a62ce8e000000b005672daedc8fsm13621058pfg.81.2022.12.30.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:50:54 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2D812103FEE; Fri, 30 Dec 2022 20:50:50 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Devicetree <devicetree@vger.kernel.org>
Cc:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/2] soc: qcom: dcc: rewrite description of dcc sysfs files
Date:   Fri, 30 Dec 2022 20:50:31 +0700
Message-Id: <20221230135030.17002-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221230135030.17002-1-bagasdotme@gmail.com>
References: <20221230135030.17002-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7900; i=bagasdotme@gmail.com; h=from:subject; bh=+poq8oGC+A48bxzOI4iT9QbeLRZ90WOVvj28TIMcLIg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnr3iy7/VTmfcHWJ1veOQfMP7ak0fu2KmPt3I9fzIx5suMd Y9P8O0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARl0pGhkVts+wVmeV4Ht9oi1/dIt LY1jhlj53Vcd5J0vw3tTaX7mP477jj+R69A/eUw9L7D29kYqib3nD6tOd83f3nH7O8mD7RhgEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of dcc sysfs files is somewhat confusing and not effective.
Rewrite it to be clear.

While at it, also use literal code block for config sysfs examples and
remove redundant examples that are obvious.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/ABI/testing/debugfs-driver-dcc | 142 ++++++++++---------
 1 file changed, 76 insertions(+), 66 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
index a00f4502885b58..27ed5919d21b9c 100644
--- a/Documentation/ABI/testing/debugfs-driver-dcc
+++ b/Documentation/ABI/testing/debugfs-driver-dcc
@@ -3,115 +3,125 @@ Date:           December 2022
 Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
 Description:
 		This file is used to check the status of the dcc
-		hardware if it's ready to take the inputs. A 'Y'
-		here indicates dcc is in a ready condition.
-		Example:
-		cat /sys/kernel/debug/dcc/.../ready
+		hardware if it's ready to receive user configurations.
+		A 'Y' here indicates dcc is ready.
 
 What:           /sys/kernel/debug/dcc/.../trigger
 Date:           December 2022
 Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
 Description:
 		This is the debugfs interface for manual software
-		triggers. The user can simply enter a 1 against
-		the debugfs file and enable a manual trigger.
-		Example:
-		echo  1 > /sys/kernel/debug/dcc/.../trigger
+		triggers. The trigger can be invoked by writing '1'
+		to the file.
 
 What:           /sys/kernel/debug/dcc/.../config_reset
 Date:           December 2022
 Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
 Description:
 		This file is used to reset the configuration of
-		a dcc driver to the default configuration. This
-		means that all the previous addresses stored in
-		the driver gets removed and user needs to enter
-		the address values from the start.
-		Example:
-		echo  1 > /sys/kernel/debug/dcc/../config_reset
+		a dcc driver to the default configuration. When '1'
+		is written to the file, all the previous addresses
+		stored in the driver gets removed and users need to
+		reconfigure addresses again.
 
 What:           /sys/kernel/debug/dcc/.../[list-number]/config
 Date:		 December 2022
 Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
 Description:
 		This stores the addresses of the registers which
-		should be read in case of a hardware crash or
-		manual software triggers. The addresses entered here
-		are considered under all the 4 types of dcc
-		instructions Read type, Write type, Read Modify Write
-		type and Loop type. The lists need to be configured
-		sequentially and not in a overlapping manner. As an
-		example user can jump to list x only after list y is
-		configured and enabled. The format for entering all
-		types of instructions are explained in examples as
-		follows:
+		can be read in case of a hardware crash or manual
+		software triggers. The input addresses type
+		can be one of following dcc instructions: read,
+		write, read-write, and loop type. The lists need to
+		be configured sequentially and not in a overlapping
+		manner; e.g. users can jump to list x only after
+		list y is configured and enabled. The input format for
+		each type is as follows:
 
-	        i) Read Type Instruction
+	        i) Read instruction
 
-		   echo R <1> <2> <3> >/sys/kernel/debug/dcc/../[list-number]/config
+		   ::
 
-		   1->Address to be considered for reading the value.
+		     echo R <addr> <n> <bus> >/sys/kernel/debug/dcc/../[list-number]/config
 
-		   2->The word count of the addresses, read n words
-		      starting from address <1>. Each word is of 32 bits.
-		      If not entered 1 is considered.
+		   where:
 
-		   3->Can be 'apb' or 'ahb' which indicates if it is apb or ahb
-		      bus respectively. If not entered ahb is considered.
+		   <addr>
+			The address to be read.
 
-		ii) Write Type Instruction
+		   <n>
+			The addresses word count, starting from address <1>.
+			Each word is 32 bits (4 bytes). If omitted, defaulted
+			to 1.
 
-		    echo W <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
+		   <bus type>
+			The bus type, which can be either 'apb' or 'ahb'.
+			The default is 'ahb' if leaved out.
 
-		    1->Address to be considered for writing the value.
+		ii) Write instruction
 
-		    2->The value that needs to be written at the location.
+		    ::
 
-		    3->Can be a 'apb' or 'ahb' which indicates if it is apb or ahb
-		       but respectively.
+		      echo W <addr> <n> <bus type> > /sys/kernel/debug/dcc/../[list-number]/config
 
-	        iii) Read Modify Write type instruction
+		    where:
 
-		     echo RW <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
+		    <addr>
+			The address to be written.
 
-		     1->The address which needs to be considered for read then write.
+		    <n>
+			The value to be written at <addr>.
 
-		     2->The value that needs to be written on the address.
+		    <bus type>
+			The bus type, which can be either 'apb' or 'ahb'.
 
-		     3->The mask of the value to be written.
+	        iii) Read-write instruction
 
-		iv) Loop Type Instruction
+		     ::
 
-		    echo L <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
+		       echo RW <addr> <n> <mask> > /sys/kernel/debug/dcc/../[list-number]/config
 
-		    1->The loop count, the number of times the value of the addresses will be
-		       captured.
+		     where:
 
-		    2->The address count, total number of addresses to be entered in this
-		       instruction.
+		     <addr>
+			The address to be read and written.
 
-		    3->The series of addresses to be entered separated by a space like <addr1>
-		       <addr2>... and so on.
+		     <n>
+		        The value to be written at <addr>.
+
+		     <mask>
+			The value mask.
+
+		iv) Loop instruction
+
+		    ::
+
+		      echo L <loop count> <address count> <address>... > /sys/kernel/debug/dcc/../[list-number]/config
+
+		    where:
+
+		    <loop count>
+			Number of iterations
+
+		    <address count>
+			total number of addresses to be written
+
+		    <address>
+			Space-separated list of addresses.
 
 What:           /sys/kernel/debug/dcc/.../[list-number]/enable
 Date:           December 2022
 Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
 Description:
 		This debugfs interface is used for enabling the
-		the dcc hardware. Enable file is kept under the
-		directory list number for which the user wants
-		to enable it. For example if the user wants to
-		enable list 1, then he should go for
-		echo 1 > /sys/kernel/debug/dcc/.../1/enable.
-		On enabling the dcc, all the addresses entered
+		the dcc hardware. A file named "enable" is in the
+		directory list number where users can enable/disable
+		the specific list by writing boolean (1 or 0) to the
+		file.
+
+		On enabling the dcc, all the addresses specified
 		by the user for the corresponding list is written
 		into dcc sram which is read by the dcc hardware
-		on manual or crash induced triggers. Lists should
-		be enabled sequentially.For example after configuring
-		addresses for list 1 and enabling it, a user can
-		proceed to enable list 2 or vice versa.
-		Example:
-		echo  0 > /sys/kernel/debug/dcc/.../[list-number]/enable
-		(disable dcc for the corresponding list number)
-		echo  1 > /sys/kernel/debug/dcc/.../[list-number]/enable
-		(enable dcc for the corresponding list number)
+		on manual or crash induced triggers. Lists must
+		be configured and enabled sequentially, e.g. list
+		2 can only be enabled when list 1 have so.
-- 
An old man doll... just what I always wanted! - Clara

