Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0D86CF389
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjC2Tqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjC2Tp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE741B8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E3261E2A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C144EC433A0;
        Wed, 29 Mar 2023 19:45:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbk1-002Rr4-2t;
        Wed, 29 Mar 2023 15:45:53 -0400
Message-ID: <20230329194553.709416963@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 23/25] tracing/user_events: Align structs with tabs for readability
References: <20230329194516.146147554@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Add tabs to make struct members easier to read and unify the style of
the code.

Link: https://lkml.kernel.org/r/20230328235219.203-13-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/user_events.h      | 14 +++---
 include/uapi/linux/user_events.h | 24 +++++-----
 kernel/trace/trace_events_user.c | 82 ++++++++++++++++----------------
 3 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 0120b3dd5b03..2847f5a18a86 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -17,13 +17,13 @@
 
 #ifdef CONFIG_USER_EVENTS
 struct user_event_mm {
-	struct list_head link;
-	struct list_head enablers;
-	struct mm_struct *mm;
-	struct user_event_mm *next;
-	refcount_t refcnt;
-	refcount_t tasks;
-	struct rcu_work put_rwork;
+	struct list_head	link;
+	struct list_head	enablers;
+	struct mm_struct	*mm;
+	struct user_event_mm	*next;
+	refcount_t		refcnt;
+	refcount_t		tasks;
+	struct rcu_work		put_rwork;
 };
 
 extern void user_event_mm_dup(struct task_struct *t,
diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
index 3e7275e3234a..2984aae4a2b4 100644
--- a/include/uapi/linux/user_events.h
+++ b/include/uapi/linux/user_events.h
@@ -25,25 +25,25 @@
 struct user_reg {
 
 	/* Input: Size of the user_reg structure being used */
-	__u32 size;
+	__u32	size;
 
 	/* Input: Bit in enable address to use */
-	__u8 enable_bit;
+	__u8	enable_bit;
 
 	/* Input: Enable size in bytes at address */
-	__u8 enable_size;
+	__u8	enable_size;
 
 	/* Input: Flags for future use, set to 0 */
-	__u16 flags;
+	__u16	flags;
 
 	/* Input: Address to update when enabled */
-	__u64 enable_addr;
+	__u64	enable_addr;
 
 	/* Input: Pointer to string with event name, description and flags */
-	__u64 name_args;
+	__u64	name_args;
 
 	/* Output: Index of the event to use when writing data */
-	__u32 write_index;
+	__u32	write_index;
 } __attribute__((__packed__));
 
 /*
@@ -52,19 +52,19 @@ struct user_reg {
  */
 struct user_unreg {
 	/* Input: Size of the user_unreg structure being used */
-	__u32 size;
+	__u32	size;
 
 	/* Input: Bit to unregister */
-	__u8 disable_bit;
+	__u8	disable_bit;
 
 	/* Input: Reserved, set to 0 */
-	__u8 __reserved;
+	__u8	__reserved;
 
 	/* Input: Reserved, set to 0 */
-	__u16 __reserved2;
+	__u16	__reserved2;
 
 	/* Input: Address to unregister */
-	__u64 disable_addr;
+	__u64	disable_addr;
 } __attribute__((__packed__));
 
 #define DIAG_IOC_MAGIC '*'
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 9b43a02e1597..67cb7b53caf6 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -53,9 +53,9 @@
  * allows isolation for events by various means.
  */
 struct user_event_group {
-	char *system_name;
-	struct hlist_node node;
-	struct mutex reg_mutex;
+	char		*system_name;
+	struct		hlist_node node;
+	struct		mutex reg_mutex;
 	DECLARE_HASHTABLE(register_table, 8);
 };
 
@@ -76,17 +76,17 @@ static unsigned int current_user_events;
  * refcnt reaches one.
  */
 struct user_event {
-	struct user_event_group *group;
-	struct tracepoint tracepoint;
-	struct trace_event_call call;
-	struct trace_event_class class;
-	struct dyn_event devent;
-	struct hlist_node node;
-	struct list_head fields;
-	struct list_head validators;
-	refcount_t refcnt;
-	int min_size;
-	char status;
+	struct user_event_group		*group;
+	struct tracepoint		tracepoint;
+	struct trace_event_call		call;
+	struct trace_event_class	class;
+	struct dyn_event		devent;
+	struct hlist_node		node;
+	struct list_head		fields;
+	struct list_head		validators;
+	refcount_t			refcnt;
+	int				min_size;
+	char				status;
 };
 
 /*
@@ -95,12 +95,12 @@ struct user_event {
  * these to track enablement sites that are tied to an event.
  */
 struct user_event_enabler {
-	struct list_head link;
-	struct user_event *event;
-	unsigned long addr;
+	struct list_head	link;
+	struct user_event	*event;
+	unsigned long		addr;
 
 	/* Track enable bit, flags, etc. Aligned for bitops. */
-	unsigned int values;
+	unsigned int		values;
 };
 
 /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
@@ -119,9 +119,9 @@ struct user_event_enabler {
 
 /* Used for asynchronous faulting in of pages */
 struct user_event_enabler_fault {
-	struct work_struct work;
-	struct user_event_mm *mm;
-	struct user_event_enabler *enabler;
+	struct work_struct		work;
+	struct user_event_mm		*mm;
+	struct user_event_enabler	*enabler;
 };
 
 static struct kmem_cache *fault_cache;
@@ -137,23 +137,23 @@ static DEFINE_SPINLOCK(user_event_mms_lock);
  * These are not shared and only accessible by the file that created it.
  */
 struct user_event_refs {
-	struct rcu_head rcu;
-	int count;
-	struct user_event *events[];
+	struct rcu_head		rcu;
+	int			count;
+	struct user_event	*events[];
 };
 
 struct user_event_file_info {
-	struct user_event_group *group;
-	struct user_event_refs *refs;
+	struct user_event_group	*group;
+	struct user_event_refs	*refs;
 };
 
 #define VALIDATOR_ENSURE_NULL (1 << 0)
 #define VALIDATOR_REL (1 << 1)
 
 struct user_event_validator {
-	struct list_head link;
-	int offset;
-	int flags;
+	struct list_head	link;
+	int			offset;
+	int			flags;
 };
 
 typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
@@ -2276,11 +2276,11 @@ static int user_events_release(struct inode *node, struct file *file)
 }
 
 static const struct file_operations user_data_fops = {
-	.open = user_events_open,
-	.write = user_events_write,
-	.write_iter = user_events_write_iter,
+	.open		= user_events_open,
+	.write		= user_events_write,
+	.write_iter	= user_events_write_iter,
 	.unlocked_ioctl	= user_events_ioctl,
-	.release = user_events_release,
+	.release	= user_events_release,
 };
 
 static void *user_seq_start(struct seq_file *m, loff_t *pos)
@@ -2346,10 +2346,10 @@ static int user_seq_show(struct seq_file *m, void *p)
 }
 
 static const struct seq_operations user_seq_ops = {
-	.start = user_seq_start,
-	.next  = user_seq_next,
-	.stop  = user_seq_stop,
-	.show  = user_seq_show,
+	.start	= user_seq_start,
+	.next	= user_seq_next,
+	.stop	= user_seq_stop,
+	.show	= user_seq_show,
 };
 
 static int user_status_open(struct inode *node, struct file *file)
@@ -2375,10 +2375,10 @@ static int user_status_open(struct inode *node, struct file *file)
 }
 
 static const struct file_operations user_status_fops = {
-	.open = user_status_open,
-	.read = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
+	.open		= user_status_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 
 /*
-- 
2.39.1
