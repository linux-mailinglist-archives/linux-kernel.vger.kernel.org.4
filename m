Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71A6602D84
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiJRN5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiJRN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:56:53 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C211AD0189;
        Tue, 18 Oct 2022 06:56:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2B6F9320034E;
        Tue, 18 Oct 2022 09:56:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 18 Oct 2022 09:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666101409; x=
        1666187809; bh=lTFkOoPNy5YkswWbKm4XWBhCI/IUy0uNzHm95cxOg84=; b=r
        u6D59ntsFAHj50dRkjBOP8gpaJD5soqeN2eV+GXOsBYRPuLe6JjuQWGa2HenDG7M
        58fzQotzvQA9m31O+yeGEY/Q36pShusK10VdaJ2aYAHF5DtnlOjbdA+WnEaOVzIy
        8zGeuJY56N1D8HyLlmqBUfLKrhoD9lpEXttj2vf02iyAMNp25lYTI6O6ByCHIBRq
        ra3dUm+1GNLeoZNqxFvuAfcyYg9I6w4PnG0jOE4ewkHEF/G79Sn1qbpoRHkWkedw
        MZsPvuurI3ct/kWa4534cTkcG/oOrhUBYmRUBXHblwle90zs8PBUD0wtG5iTgg+W
        zcrcuRAgfA5DWzRMQ7l+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666101409; x=
        1666187809; bh=lTFkOoPNy5YkswWbKm4XWBhCI/IUy0uNzHm95cxOg84=; b=M
        47x+8DVUJx2G+K68cZd16MqzWK2faVXinP4OaN9YlSXjoi7MD08CN/dRXmUwQZv1
        8eFEJJQ9fwWo6IPAD5VaBJ43pzHxba9tUi5+rMegvp5nT5/2jdbyFwO035hdWSil
        YrGVYba2RslcI1unB0KJCi7Gx7VlQ21d6WGDKBBVEHwM8G7KrNu5Aasb8TRYXzub
        J4UA5Vi4Na/I3CfCEcByb5PaCb8qF0vqQrRlMNiscQUO/IfTPod6/r1UVAKRUp82
        QMx2OpyTS5vb4Xm8rMj3tHxJxfTHivd2gwSLiCbN7vQI2Yes4YkIw6iZUWv1IMO3
        13q7xrLP6ZnUl/JgjVdVA==
X-ME-Sender: <xms:obBOY6cMI8mDw9nok3ps6rL-PHL4QbX2zH4cdLIIp2drc8ZwXeQ1ag>
    <xme:obBOY0OJNOXnhAW18tQwZFYRu_AL-R0DqTUXY3MwWKSIIz8Yl5jG8udfTiu10uyWv
    S166Dyul7FTJHiTs18>
X-ME-Received: <xmr:obBOY7j71GWczOd-nHUARp4YusnWdTj2bjqSIPsjI8RC5VZFY05UQWCUvcXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:obBOY3_pWZhNKuaeJdhVICoKAWhTd17HeoNDg94eSEeErzg-wtHNCQ>
    <xmx:obBOY2tJaEU5YOCB1hlf_aAdixw242US5nsZRVkLMHv41loQrN2j5A>
    <xmx:obBOY-EA6DhK1Dq04MNc12vMlQYTDZd9dV1TU9_2_vq_OaQCCrY1GQ>
    <xmx:obBOY4VSTAwu7QuLZ2-CiI1Kja4bWB5NBsUXxQ7NtAA8-JnhhfFtvA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 09:56:49 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 18 Oct 2022 15:56:42 +0200
Subject: [PATCH 2/2] clk: Add trace events for rate requests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-clk-rate-request-tracing-v1-2-6f3aa0b0b9de@cerno.tech>
References: <20221018-clk-rate-request-tracing-v1-0-6f3aa0b0b9de@cerno.tech>
In-Reply-To: <20221018-clk-rate-request-tracing-v1-0-6f3aa0b0b9de@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=5614; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=BkBIerSMdamyC64SYrDzkQInjQFkK6FdirzCXmlc5f4=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMl+G2Y168b/4sg92il058KHGQlu71hVfpiIyc6wcW2RlU1b
 NoW3o5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABNR+MLIsMOfdf2KKYWK61gsX11vul
 fSmH3r+xRZU1mlHm3eiOvTNjEybDtSvY692nXFSt685AfGq2J8JocHOQda8VeGOs/mYFnLDgA=
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is currently fairly difficult to follow what clk_rate_request are
issued, and how they have been modified once done.

Indeed, there's multiple paths that can be taken, some functions are
recursive and will just forward the request to its parent, etc.

Adding a lot of debug prints is just not very convenient, so let's add
trace events for the clock requests, one before they are submitted and
one after they are returned.

That way we can simply toggle the tracing on without modifying the
kernel code and without affecting performances or the kernel logs too
much.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/clk.c          | 31 +++++++++++++++++++++++++++++++
 include/trace/events/clk.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index bc6f964cb676..343c50e7e214 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -603,10 +603,15 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 			}
 
 			clk_core_forward_rate_req(core, req, parent, &parent_req, req->rate);
+
+			trace_clk_rate_request_start(&parent_req);
+
 			ret = clk_core_round_rate_nolock(parent, &parent_req);
 			if (ret)
 				return ret;
 
+			trace_clk_rate_request_done(&parent_req);
+
 			best = parent_req.rate;
 		} else if (parent) {
 			best = clk_core_get_rate_nolock(parent);
@@ -630,10 +635,15 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 			struct clk_rate_request parent_req;
 
 			clk_core_forward_rate_req(core, req, parent, &parent_req, req->rate);
+
+			trace_clk_rate_request_start(&parent_req);
+
 			ret = clk_core_round_rate_nolock(parent, &parent_req);
 			if (ret)
 				continue;
 
+			trace_clk_rate_request_done(&parent_req);
+
 			parent_rate = parent_req.rate;
 		} else {
 			parent_rate = clk_core_get_rate_nolock(parent);
@@ -1551,10 +1561,15 @@ static int clk_core_round_rate_nolock(struct clk_core *core,
 		struct clk_rate_request parent_req;
 
 		clk_core_forward_rate_req(core, req, core->parent, &parent_req, req->rate);
+
+		trace_clk_rate_request_start(&parent_req);
+
 		ret = clk_core_round_rate_nolock(core->parent, &parent_req);
 		if (ret)
 			return ret;
 
+		trace_clk_rate_request_done(&parent_req);
+
 		req->best_parent_rate = parent_req.rate;
 		req->rate = parent_req.rate;
 
@@ -1605,10 +1620,14 @@ unsigned long clk_hw_round_rate(struct clk_hw *hw, unsigned long rate)
 
 	clk_core_init_rate_req(hw->core, &req, rate);
 
+	trace_clk_rate_request_start(&req);
+
 	ret = clk_core_round_rate_nolock(hw->core, &req);
 	if (ret)
 		return 0;
 
+	trace_clk_rate_request_done(&req);
+
 	return req.rate;
 }
 EXPORT_SYMBOL_GPL(clk_hw_round_rate);
@@ -1637,8 +1656,12 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 
 	clk_core_init_rate_req(clk->core, &req, rate);
 
+	trace_clk_rate_request_start(&req);
+
 	ret = clk_core_round_rate_nolock(clk->core, &req);
 
+	trace_clk_rate_request_done(&req);
+
 	if (clk->exclusive_count)
 		clk_core_rate_protect(clk->core);
 
@@ -2130,10 +2153,14 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 
 		clk_core_init_rate_req(core, &req, rate);
 
+		trace_clk_rate_request_start(&req);
+
 		ret = clk_core_determine_round_nolock(core, &req);
 		if (ret < 0)
 			return NULL;
 
+		trace_clk_rate_request_done(&req);
+
 		best_parent_rate = req.best_parent_rate;
 		new_rate = req.rate;
 		parent = req.best_parent_hw ? req.best_parent_hw->core : NULL;
@@ -2329,8 +2356,12 @@ static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
 
 	clk_core_init_rate_req(core, &req, req_rate);
 
+	trace_clk_rate_request_start(&req);
+
 	ret = clk_core_round_rate_nolock(core, &req);
 
+	trace_clk_rate_request_done(&req);
+
 	/* restore the protection */
 	clk_core_rate_restore_protect(core, cnt);
 
diff --git a/include/trace/events/clk.h b/include/trace/events/clk.h
index e19edc63ee95..b19f5a549219 100644
--- a/include/trace/events/clk.h
+++ b/include/trace/events/clk.h
@@ -264,6 +264,49 @@ DEFINE_EVENT(clk_duty_cycle, clk_set_duty_cycle_complete,
 	TP_ARGS(core, duty)
 );
 
+DECLARE_EVENT_CLASS(clk_rate_request,
+
+	TP_PROTO(struct clk_rate_request *req),
+
+	TP_ARGS(req),
+
+	TP_STRUCT__entry(
+		__string(        name, req->core ? req->core->name : "none")
+		__field(unsigned long,           min                       )
+		__field(unsigned long,           max                       )
+		__string(       pname, req->best_parent_hw ? clk_hw_get_name(req->best_parent_hw) : "none" )
+		__field(unsigned long,           prate                     )
+	),
+
+	TP_fast_assign(
+		__assign_str(name, req->core ? req->core->name : "none");
+		__assign_str(pname, req->best_parent_hw ? clk_hw_get_name(req->best_parent_hw) : "none");
+		__entry->min = req->min_rate;
+		__entry->max = req->max_rate;
+		__entry->prate = req->best_parent_rate;
+	),
+
+	TP_printk("%s min %lu max %lu, parent %s (%lu)", __get_str(name),
+		  (unsigned long)__entry->min,
+		  (unsigned long)__entry->max,
+		  __get_str(pname),
+		  (unsigned long)__entry->prate)
+);
+
+DEFINE_EVENT(clk_rate_request, clk_rate_request_start,
+
+	TP_PROTO(struct clk_rate_request *req),
+
+	TP_ARGS(req)
+);
+
+DEFINE_EVENT(clk_rate_request, clk_rate_request_done,
+
+	TP_PROTO(struct clk_rate_request *req),
+
+	TP_ARGS(req)
+);
+
 #endif /* _TRACE_CLK_H */
 
 /* This part must be outside protection */

-- 
b4 0.11.0-dev-7da52
