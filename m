Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210F5693A3E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 22:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBLVR5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 12 Feb 2023 16:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjBLVRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 16:17:51 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6C72696
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 13:17:49 -0800 (PST)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 927FB405B3;
        Sun, 12 Feb 2023 21:17:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id C14942000E;
        Sun, 12 Feb 2023 21:17:46 +0000 (UTC)
Message-ID: <829b122da52482707b783dc3d93d3ff0179cb0ca.camel@perches.com>
Subject: [PATCH RESEND] get_maintainer: add email addresses from dts files
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Date:   Sun, 12 Feb 2023 13:17:45 -0800
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: C14942000E
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: u7fgahk73beu94mu9qfs5tu3k9n9paen
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1++9x1c4yUEWrdIhxX5R5WnGZH5NhUyhrg=
X-HE-Tag: 1676236666-159279
X-HE-Meta: U2FsdGVkX1+Zmkeei4OmzFuNjbpRUUeOAtZL5jouiBz0Z9rjO/+vLGVaDkZr4woVoF+vek9sDPaYASfvg4KfdA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Guo <shawnguo@kernel.org>

MAINTAINER file will get bloated quickly if individual section entry
is created for each .dts/.dtsi file.  Add the email address from dts
files to get_maintainer output for saving unnecessary patching on
MAINTAINER file.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Joe Perches <joe@perches.com>
---

Hey Andrew.  This was originally sent a year and a half ago.

Link: https://lore.kernel.org/all/20210809080204.8381-1-shawnguo@kernel.org/

Please pick this up.  Thanks.

 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 2075db0c08b8..15aa8f947f4b 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -436,7 +436,7 @@ sub maintainers_in_file {
 
     return if ($file =~ m@\bMAINTAINERS$@);
 
-    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
+    if (-f $file && ($email_file_emails || $file =~ /\.(?:yaml|dtsi?)$/)) {
 	open(my $f, '<', $file)
 	    or die "$P: Can't open $file: $!\n";
 	my $text = do { local($/) ; <$f> };

