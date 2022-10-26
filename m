Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBC760E27D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiJZNsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiJZNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:48:00 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48C5105CF3;
        Wed, 26 Oct 2022 06:47:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2A64D5C007A;
        Wed, 26 Oct 2022 09:47:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 26 Oct 2022 09:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666792053; x=
        1666878453; bh=xI1tsfHLvEMtX5r1eIWCouHcztFGCTV7dpqnVfKOqCI=; b=p
        wPIwCWqDOOTPp6b6Wp1pZwCyMyyoJ4Tjyr//WYt9gY3zJiNQF0N/S0IZ2j3IiVaj
        bvDtFUHAq4M5aU3RCmcwi3FgQbvIOfQ5jbKO2AUKO3R0Bxddrz/NOxgkJtVWs5zg
        X0x/xzBZSskKiS7aoF3oAeHAGmDHGZ2QM5VgoXb9KUdBb5wJL1daQawX/cQZ4ITl
        XNW8jOD47TjY1W62eC+r/O4RPYthn/+UUwChcQ2ttuPkG/RYMAW6ZaBu6yoXxu5I
        XHuaqUrbeJP2XXXaBgra0iYueocjRMs1d5Bb33z6QcBRz+5EsdfLyJ7ZZjqv60GJ
        CLu4pH7e7sVWUeG4OlX4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666792053; x=
        1666878453; bh=xI1tsfHLvEMtX5r1eIWCouHcztFGCTV7dpqnVfKOqCI=; b=D
        7XzyEH0uPPAsJFdaA9NhKwaUOp7U1hrwPZ1ItM7PBoNyQn5+zaLEYofEJGrNz8ei
        QjNcZGpZAiit8EYyRZvSCs/nOd5TmnWMDCpPRnKT0iARKNj742ejm8n2MhucTn4Z
        xQ0PhRKpRTlFi6e2xhab77YeW6UoTLwLXc4ksTCXFESOqt48GZOU5zS1lhtFB4yp
        ecrZg6fsTXbzU/IAEXzZ3LUUHalH1LP9h0YkTXev0Cy5OaD0KpEqUpO9YyW+KuAP
        +/erDptyxu/oBK95w5j+qj9cxfmBk7MDW8HOXmRqqLbl7a9UAzxAAKOVjAmUwobY
        +Dl4/JC4G7G2eTtYI1QnQ==
X-ME-Sender: <xms:dDpZYzOZQP14_kdaW5u_GPEdQipU6_9gkBy6OGg77Pf9KDjJNYrp-g>
    <xme:dDpZY98oH5vG13hMZZVQGMwldEM5aNwpgZSxkHoJQH7XrP0V8iXDWlMMNueHAs450
    HmMjh03h2C3Ydp0X80>
X-ME-Received: <xmr:dDpZYyQZ8RH8Jf-zO8y-F4tInGLMsvvPE9DxzT0zayoK08aHqB96NNjkO13GeU4ige46K7xDCz90oA2EZTVa1UBYaJszRuXEcDR5arw4fYmH5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepmhgrgihi
    mhgvsegtvghrnhhordhtvggthhenucggtffrrghtthgvrhhnpeefudfhgeevhefhfedtue
    evueeluddutdetuddtvddvgeekheelvefhteekteeihfenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtg
    hh
X-ME-Proxy: <xmx:dTpZY3t4UeoDOLDqfISlGK6kNdW5BVpuCOO16XiTiJ_dXHHStJKjuA>
    <xmx:dTpZY7eSlu5d2LzToH5Lv220A8YrOWJ-fWa9ydRP2bbLs8Ng4qWoug>
    <xmx:dTpZYz1-h1ErlNS8zlwhifAPVLCM4RojuLrwiDk1fIEnTgBQaQUCuA>
    <xmx:dTpZY539s150Fw5tydFJhmq9QuKriAsti75BvUEt4zQkJFBZrGCVxQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 09:47:32 -0400 (EDT)
From:   maxime@cerno.tech
Date:   Wed, 26 Oct 2022 15:46:59 +0200
Subject: [PATCH v2 2/2] clk: Add trace events for rate requests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-clk-rate-request-tracing-v2-2-5170b363c413@cerno.tech>
References: <20221018-clk-rate-request-tracing-v2-0-5170b363c413@cerno.tech>
In-Reply-To: <20221018-clk-rate-request-tracing-v2-0-5170b363c413@cerno.tech>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5664; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=d6EIls9vpGf2tP8fqMCYnupVPvHrtJyms/XyJWeC0ek=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMmRViG7fl68783BcThzx51jhdPVRL/v1Hc7ED5ZUcnFeZOZ
 rhZbRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACbC3cvwP01q3Y76O5eXL903/8C2jP
 qX/L3tM/dy/3L6svSQz4OsRUaMDL//LzVj+8yvKy7Wc4ufJ8yirCpcJaqnX+JvweT23wGi7AA=
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
index e19edc63ee95..daed3c7a48c1 100644
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
+		__string(       pname, req->best_parent_hw ? clk_hw_get_name(req->best_parent_hw) : "none" )
+		__field(unsigned long,           min                       )
+		__field(unsigned long,           max                       )
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
b4 0.10.1
