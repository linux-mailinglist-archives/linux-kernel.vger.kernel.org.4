Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF56C7E07
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCXM1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjCXM1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:27:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF9265BB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D28DB81334
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F37C433D2;
        Fri, 24 Mar 2023 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679660854;
        bh=pBPJ6+C4oAIi7xTrzrMKIzMGw/3RnX9ubBLYHwro+/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koDDcoNE5VMA2KjP5YvbaTpj5WpUkGIO8ed5Cd15GhiavxVbB7MiUbMPB4QYI5ILL
         lufs/zo3q1M21fdaUFwu+mooxFUUVyHq1dGnK5dponO8JcfLO8+N8t05KA+n7rcWG+
         pOvpLUR9e7kFcjiRaWn9rNrd4D4oGklE0FnRXm88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 6/6] kobject.h remove extern from function prototypes
Date:   Fri, 24 Mar 2023 13:27:11 +0100
Message-Id: <20230324122711.2664537-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
References: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4587; i=gregkh@linuxfoundation.org; h=from:subject; bh=pBPJ6+C4oAIi7xTrzrMKIzMGw/3RnX9ubBLYHwro+/M=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmy0+UzZ+wxfp9kwXiyO9E+UP5Z9n0R121vr7LtsQ3g2 iiu4xPaEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABM5f5thQffnuPsz56Vfzzlj zsF7Sz37ZHrTcYYFzd9fB9+IOjw3N4Or9PDSB+Fdhu4WAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel coding style does not require 'extern' in function prototypes
in .h files, so remove them from include/linux/kobject.h as they are not
needed.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/kobject.h | 59 ++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index bdab370a24f4..c392c811d9ad 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -79,43 +79,37 @@ struct kobject {
 	unsigned int uevent_suppress:1;
 };
 
-extern __printf(2, 3)
-int kobject_set_name(struct kobject *kobj, const char *name, ...);
-extern __printf(2, 0)
-int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
-			   va_list vargs);
+__printf(2, 3) int kobject_set_name(struct kobject *kobj, const char *name, ...);
+__printf(2, 0) int kobject_set_name_vargs(struct kobject *kobj, const char *fmt, va_list vargs);
 
 static inline const char *kobject_name(const struct kobject *kobj)
 {
 	return kobj->name;
 }
 
-extern void kobject_init(struct kobject *kobj, const struct kobj_type *ktype);
-extern __printf(3, 4) __must_check
-int kobject_add(struct kobject *kobj, struct kobject *parent,
-		const char *fmt, ...);
-extern __printf(4, 5) __must_check
-int kobject_init_and_add(struct kobject *kobj,
-			 const struct kobj_type *ktype, struct kobject *parent,
-			 const char *fmt, ...);
+void kobject_init(struct kobject *kobj, const struct kobj_type *ktype);
+__printf(3, 4) __must_check int kobject_add(struct kobject *kobj,
+					    struct kobject *parent,
+					    const char *fmt, ...);
+__printf(4, 5) __must_check int kobject_init_and_add(struct kobject *kobj,
+						     const struct kobj_type *ktype,
+						     struct kobject *parent,
+						     const char *fmt, ...);
 
-extern void kobject_del(struct kobject *kobj);
+void kobject_del(struct kobject *kobj);
 
-extern struct kobject * __must_check kobject_create_and_add(const char *name,
-						struct kobject *parent);
+struct kobject * __must_check kobject_create_and_add(const char *name, struct kobject *parent);
 
-extern int __must_check kobject_rename(struct kobject *, const char *new_name);
-extern int __must_check kobject_move(struct kobject *, struct kobject *);
+int __must_check kobject_rename(struct kobject *, const char *new_name);
+int __must_check kobject_move(struct kobject *, struct kobject *);
 
-extern struct kobject *kobject_get(struct kobject *kobj);
-extern struct kobject * __must_check kobject_get_unless_zero(
-						struct kobject *kobj);
-extern void kobject_put(struct kobject *kobj);
+struct kobject *kobject_get(struct kobject *kobj);
+struct kobject * __must_check kobject_get_unless_zero(struct kobject *kobj);
+void kobject_put(struct kobject *kobj);
 
-extern const void *kobject_namespace(const struct kobject *kobj);
-extern void kobject_get_ownership(const struct kobject *kobj,
-				  kuid_t *uid, kgid_t *gid);
-extern char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
+const void *kobject_namespace(const struct kobject *kobj);
+void kobject_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid);
+char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
 
 struct kobj_type {
 	void (*release)(struct kobject *kobj);
@@ -176,12 +170,11 @@ struct kset {
 	const struct kset_uevent_ops *uevent_ops;
 } __randomize_layout;
 
-extern void kset_init(struct kset *kset);
-extern int __must_check kset_register(struct kset *kset);
-extern void kset_unregister(struct kset *kset);
-extern struct kset * __must_check kset_create_and_add(const char *name,
-						const struct kset_uevent_ops *u,
-						struct kobject *parent_kobj);
+void kset_init(struct kset *kset);
+int __must_check kset_register(struct kset *kset);
+void kset_unregister(struct kset *kset);
+struct kset * __must_check kset_create_and_add(const char *name, const struct kset_uevent_ops *u,
+					       struct kobject *parent_kobj);
 
 static inline struct kset *to_kset(struct kobject *kobj)
 {
@@ -203,7 +196,7 @@ static inline const struct kobj_type *get_ktype(const struct kobject *kobj)
 	return kobj->ktype;
 }
 
-extern struct kobject *kset_find_obj(struct kset *, const char *);
+struct kobject *kset_find_obj(struct kset *, const char *);
 
 /* The global /sys/kernel/ kobject for people to chain off of */
 extern struct kobject *kernel_kobj;
-- 
2.40.0

