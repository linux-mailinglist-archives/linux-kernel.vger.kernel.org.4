Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D026594A2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 05:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiL3EVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 23:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiL3EVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 23:21:18 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DC4266C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 20:21:17 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E5795C0349;
        Thu, 29 Dec 2022 23:21:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 29 Dec 2022 23:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672374076; x=1672460476; bh=JN
        9NFHKSRoX2NmbrNsnkR20cy9kBqiSvPpqIXpLNJ9I=; b=IoeRkN1WglL20SiCEh
        2UQIey6viwF29x0zjR7Q9s4ltywDVuL8CFWtA7hAkUZWMFS2gpE+yypCxU3LnTxX
        fbJFTH45w6Irl0veEzPsEYD6QjMmsC4rDLLPbKsc0DPk4LE7ryT4YmYHqeQ3fqfS
        gRT6W16jUV2Pv/L+SIe8EBfEXJ7E3c5vfUotPnteOHBkU1mjInfwqXSVWfCdBgtz
        qDHyjp+lGAOlk5EkqVzPQf80ROpaJVT9dfsPKQptwFuXapvZQ4PmlC8g4tY/wbuD
        QdyS8jPi7EvCxIcVxJqBYnnAl4zFCd4M5/mMrtx8ppWb/K9I2QrVAkYHCtnh14I/
        ZyWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672374076; x=1672460476; bh=JN9NFHKSRoX2N
        mbrNsnkR20cy9kBqiSvPpqIXpLNJ9I=; b=tp8/pSEset17Jvwo3IfyyS8nEYDTn
        /rOyZWHEij7SxFlKtuw1jFWtOxWHeORgKx4+398lx53JMKTPX0qMxUm+PqJrLCGr
        Bs4BGCBmtbhIjXiS6zxFE1zEiDdMeuUNWxll5zOfun3vtZytvjFv2bFUxaEMObgH
        j7Jl+x+/9qtiRLp68yoxjxmVKLQH3HQO+uFJnMjqUwAq/XR0NjGgKYAkev+4YHFe
        mL5gZ+dKVf3jmbboCRTmIFIpp5Ixqu5byKKJcvOwifzV41dhaEwfqawlayPPEuUK
        nrxhn+YTpZkB8oe4v5iUcx5LIMjAx1w5cOfq9XAYqFd1sNQn4QC4c3GiQ==
X-ME-Sender: <xms:PGeuY-P0RrmIx9IQz4zXeG4hQlt12WBR8OA0DCjv3usibIlKqEh0VA>
    <xme:PGeuY89SdIYPtDDpkK52wf-IEBlA708Zpu3SfDfzJXcGmvB-ebFPnBGdhkf8IiHOc
    lbAKpBKltfUq1xK1A>
X-ME-Received: <xmr:PGeuY1SUIZI34eRtyXlcGDotWl7enNbLNIZTTlMrP3-yVhsAyj5HumFvYAjryVmTjLl4Da43mZ6d-XIOJ7irqlfi5Hham8fQwcw28W1rAbamMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieehgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdduhedmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhr
    vgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecuggftrfgrthhtvghrnhephf
    dvuefgtddvieeigefffeffkeeigedvgfeitdejteffveefhfdtheejffeiiedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrse
    hruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:PGeuY-sL4z096z7Db4_wOL_-WhwCPbTWD5aDKmK0Jy_HttNCGtnafA>
    <xmx:PGeuY2f5SFnaS6yFaOli_MlTl3svbRVDy7-tkKw3QS1guY4kIs22MQ>
    <xmx:PGeuYy1X_1H7PYhevvBHf81Qy78YLM6qNoR2LQTNnBvIR6mGEKdj5w>
    <xmx:PGeuY8suZCQ3sZG9TXJc-xvcbVXmolHZN-3fbzo2xDZmCNxwoVJ1lQ>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 23:21:13 -0500 (EST)
From:   Russell Currey <ruscur@russell.cc>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ajd@linux.ibm.com, zohar@linux.ibm.com, mpe@ellerman.id.au,
        Russell Currey <ruscur@russell.cc>
Subject: [PATCH v2 3/7] powerpc/secvar: Use sysfs_emit() instead of sprintf()
Date:   Fri, 30 Dec 2022 15:20:10 +1100
Message-Id: <20221230042014.154483-4-ruscur@russell.cc>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230042014.154483-1-ruscur@russell.cc>
References: <20221230042014.154483-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secvar format string and object size sysfs files are both ASCII
text, and should use sysfs_emit().  No functional change.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
v2: new

 arch/powerpc/kernel/secvar-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 1ee4640a2641..02e9fee1552e 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -35,7 +35,7 @@ static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
 	if (rc)
 		goto out;
 
-	rc = sprintf(buf, "%s\n", format);
+	rc = sysfs_emit(buf, "%s\n", format);
 
 out:
 	of_node_put(node);
@@ -57,7 +57,7 @@ static ssize_t size_show(struct kobject *kobj, struct kobj_attribute *attr,
 		return rc;
 	}
 
-	return sprintf(buf, "%llu\n", dsize);
+	return sysfs_emit(buf, "%llu\n", dsize);
 }
 
 static ssize_t data_read(struct file *filep, struct kobject *kobj,
-- 
2.38.1

