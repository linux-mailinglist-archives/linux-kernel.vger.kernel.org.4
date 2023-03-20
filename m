Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43376C06D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 01:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCTAck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 20:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCTAci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:32:38 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8586F168B3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 17:32:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DFDFF5C00BA;
        Sun, 19 Mar 2023 20:32:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 19 Mar 2023 20:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679272353; x=
        1679358753; bh=iwPU2XUoORcrqxgWnL7qQpsymVVO5t7PxaOWHT9jlq4=; b=C
        00Hio0rKz2qHrJrV/M0gZ59GCcgOB7qtFIVEE9CxnYxSb+UqxO+Mas/kFePj1CG0
        fvVmSLzCBxWGd31+327oOeZhXQp4kFSwpGHchnERuLGfanccv+lorCF6o+k8L9Lq
        Q+4zMEH0NUOQ26Zy/IJPab+B73aJnlG/B+L06vaxZ+ZQBvrW0tM6iBrYZhjkrKlR
        XUVUFNRTpbtFtp/Q/iOSR0cRuFA96H8IpLuSJTULUZqYZ1sUDF1CcorKbFQgFCh4
        6k68/kFlvly64oOypRer5zaRjQdr/OQtWB0I1euVZkG6vJukiCsXuJNAlhEJSXBL
        YKgpTjdNj26edaCtiyQBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1679272353; x=
        1679358753; bh=iwPU2XUoORcrqxgWnL7qQpsymVVO5t7PxaOWHT9jlq4=; b=A
        /gN8Tp0KGpuCQ2Xs/NPe/tWeVCkfMQNplm/nOPrsYLGdQ7Siq0DHrol0XYkr1oTh
        RaeJrH+NB4Qwc1pOp0zlVx8zehLJ8lrWptOSe8Cy+zcvbbNNrsxPJ9OQ21MNeok6
        hKeHPrJSt9SHfQ0vmo713yRHGPjiriwLT/elqlVSG+X64PfdqlOV1lGbOcXoLe9E
        WrcBWqx+wvfdgjwpjnh57zk+c2i/UkxeFNX2tRE4L/GHrWCQwu3PcpfBppb856VU
        4ffHwRkcAkDBCsNyFscEd3LKv1mmWc2Io7wK2nUNUaa1HaT9XOG6Ltr0KK1q6eAl
        VwO/3z9/JvHqnNG2hA9nQ==
X-ME-Sender: <xms:oakXZNO_0a_uLjZdCHiQovSwnsoefwqUvj6y2EMeTrxxCVBmYdXRhQ>
    <xme:oakXZP9aIGfRMan7f92Cg7PsKwRSgcieopHlscdsZcKMSqE6onYClqICCA0_oNJoU
    9RJeOQBs6c4gkaAZUk>
X-ME-Received: <xmr:oakXZMQw_Pb0eYtMht3DDlJdiQKiv1GoB_QASfw7vZHhA3FYs6MEnDQ4LvBQsE_ICPX-bTv04XJMGxc_cbW7J27hxc-ruq9ScXUkxxsT6fnktya6-ddDuHJ4lA-xn477N-2tUsgZEMT1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefjedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueet
    hefgvdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:oakXZJtHxO5OmehtbztSQoUP9JM-1UNSecy2_XIfPgzJDEbryKbA0Q>
    <xmx:oakXZFeDD6ubvQ52uMUTIBmX3svZbnALmwqoVHU9iHJ5MHJ0g9RvTw>
    <xmx:oakXZF2ytcwOAQWKwZIDA10qT_wQqmDvffgpO-nJuE9_qMW4UDMCJg>
    <xmx:oakXZOEVP7naDiE9t9UiD7Fl6htTem85o39pe0MOeiqZmg0WUA6t_g>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Mar 2023 20:32:33 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org, markpearson@lenovo.com,
        thomas@t-8ch.de, pobrn@protonmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] platform/x86: think-lmi: Add possible_values for ThinkStation
Date:   Sun, 19 Mar 2023 20:32:21 -0400
Message-Id: <20230320003221.561750-4-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320003221.561750-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230320003221.561750-1-mpearson-lenovo@squebb.ca>
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

ThinkStation platforms don't support the API to return possible_values
but instead embed it in the settings string.

Try and extract this information and set the possible_values attribute
appropriately.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v4:
 - is_visible handling split out into separate patch
 - linelength reduced so checkpatch is clean.
Changes in v3:
 - Use is_visible attribute to determine if possible_values should be
   available
 - Code got refactored a bit to make compilation cleaner
Changes in v2:
 - Move no value for possible_values handling into show function
 - use kstrndup for allocating string

 drivers/platform/x86/think-lmi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 6f8c91716a95..aaaeb30fb0b0 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1422,6 +1422,26 @@ static int tlmi_analyze(void)
 			if (ret || !setting->possible_values)
 				pr_info("Error retrieving possible values for %d : %s\n",
 						i, setting->display_name);
+		} else {
+			/*
+			 * Older Thinkstations don't support the bios_selections API.
+			 * Instead they store this as a [Optional:Option1,Option2] section of the
+			 * name string.
+			 * Try and pull that out if it's available.
+			 */
+			char *item, *optstart, *optend;
+
+			if (!tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID)) {
+				optstart = strstr(item, "[Optional:");
+				if (optstart) {
+					optstart += strlen("[Optional:");
+					optend = strstr(optstart, "]");
+					if (optend)
+						setting->possible_values =
+							kstrndup(optstart, optend - optstart,
+									GFP_KERNEL);
+				}
+			}
 		}
 		/*
 		 * firmware-attributes requires that possible_values are separated by ';' but
-- 
2.39.2

