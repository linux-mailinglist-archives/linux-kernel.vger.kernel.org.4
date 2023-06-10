Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB62B72AD93
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjFJRIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjFJRIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:08:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE54E2D74;
        Sat, 10 Jun 2023 10:07:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 555E85C00D2;
        Sat, 10 Jun 2023 13:07:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 10 Jun 2023 13:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1686416879; x=1686503279; bh=7Jo4c9QtvH
        tlbToAB55IunRxRJMuKNem21WfUtrWYf0=; b=R4G872AhYLcgiVT64bv01uWxyk
        UTwIQzhAviwtIXFLPZXZvAExiP7zCJC1L2DwDvix0Y/EASfsycXqZVWDZYv/W4KD
        wa1afVEZ+1fTLXff2BL4wiL1DmJUjneB6egjzzThpU7oSwT+n5VRD1uhE3af5Vfy
        vn3SNtiLfO9TOfggoGNENKVz4LorILzprI6jhwRDoyledV1PZ4Z+7BRY315l64et
        DJoAyfYhYPgCJnu+1QxzEKf4KKCEh/oPuFIgP+1RdfOEv9whP+j9vPOvziuk8757
        4sBfrpQU0TpgjfT9CRKmXccMjv+U4IhX4fbkDzlw5y1ICiUdvgEkDaTKyjnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1686416879; x=
        1686503279; bh=7Jo4c9QtvHtlbToAB55IunRxRJMuKNem21WfUtrWYf0=; b=X
        oovcJPuoEjGfvUgRl8xODTUTUISTuoR53DYOjfKU+/3BDsVh9AoXonh+6CGk2Bx7
        V6rmqF7vS8zoo1Tq/Mq+uSoXdTEUeB0XrE2Z81DFUu+eZzgi4O6WstMXfs6vCds5
        a3tvdw7mykCNksP4Xqmjr1YqdJZIrni8VQVutX3OVk46TMhnc1+4v2rWIJW82eAL
        HJk7AWeud3HyBNvLmjin43Ig0qw3YGZb7qhEJHmFsRUDnYKcaRYlV3Lz9PH7ZGKC
        jHdNH/JiBTewLNml7VzaJoNy/fFJAOtQt80QOMes9VM8/dV+0Vw2NN2wp34Ht7ae
        uQRe+sBFu1chU7B7k9vqg==
X-ME-Sender: <xms:762EZFtrsXGWH6Bi3vsdNf7KO0WeAt9CZgF_sw0uvbT6nPQTRvmhrg>
    <xme:762EZOeT2PjJFMbEpxkmF7v5Ty5_38noAd9nNqfMz21lY7bnR-tZACZY5n9yd1A9l
    HxBXgLwPt8Ypd8>
X-ME-Received: <xmr:762EZIzbbCs6lnlbpMn_MlYje7UdvucwNz94immORIpcW5DKbdPhrri6mwCDj-bwC0Rald-kszY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedutddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeekveekveegudffgffgleekudeu
    keetlefgveelhfehuedtfedvgfeklefhtefgfeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    uggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:762EZMOujFzVTRxP5-Stj3u7XjXaI8pS8gkgQzJSuiZZTSb2tQ0tvg>
    <xmx:762EZF9f8T4nECydLj9PLL5sjS1r2O07qLaoojvZ21krMTEcyVSMZQ>
    <xmx:762EZMWR73avhokyajzpl_EzpP-Mqwt25X8qAzLefJ4m4wpvN7lrWg>
    <xmx:762EZMjEEqz6bjWwVaBe2mGNSoOxz4EDSPbBgCo8kz67pTPZdFl0vw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jun 2023 13:07:57 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/3] vsscanf(): do not skip spaces
Date:   Sat, 10 Jun 2023 13:07:42 -0400
Message-Id: <20230610170743.2510-3-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610170743.2510-1-demi@invisiblethingslab.com>
References: <20230610170743.2510-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing spaces before e.g. an integer is usually
not intended.  This was suggested by Christoph in
https://lore.kernel.org/lkml/ZIQrohcizoj4bZWx@infradead.org/.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 lib/vsprintf.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 8caccdcda0a2b470cda70c9b3837de37207eb512..d2d795d1aff0fd5cc50fb65ffb067067ab9f0dc6 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3547,8 +3547,6 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			char *s = (char *)va_arg(args, char *);
 			if (field_width == -1)
 				field_width = SHRT_MAX;
-			/* first, skip leading white space in buffer */
-			str = skip_spaces(str);
 
 			/* now copy until next white space */
 			while (*str && !isspace(*str) && field_width--)
@@ -3635,11 +3633,7 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			return num;
 		}
 
-		/* have some sort of integer conversion.
-		 * first, skip white space in buffer.
-		 */
-		str = skip_spaces(str);
-
+		/* have some sort of integer conversion. */
 		digit = *str;
 		if (is_sign && digit == '-') {
 			if (field_width == 1)
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

