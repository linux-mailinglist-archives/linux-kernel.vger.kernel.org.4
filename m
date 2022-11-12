Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380DE62668F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiKLDPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLDPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:15:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069BDF82
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 19:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=M+L+lRM1vNwuQLc83B4c5E2VUXH7qst6YWtlzjE9SMY=; b=baZP/2LjIg7pfYtqakXM16QcVq
        dp95bX8inmGoz32KohvnqTM/JIbvzFQLu378GIgpTFFjbPcWVmWVORIxwm1SLQbXh+uJUsofLz47Y
        OahPt6s9SV7AwXI8E/YHYhnd3lfsdIhnUhLo1S1WSyMioshNFNjo9/rUvs5SxPfqEjGs4KorGvtqx
        JgOMHCUG+gEQK+fNLa6bQnJg1X/cR0zs1dc0g+XeMiTpvCVgNhlbXnzv2dcOE5CAGPpEgBBGy1cwy
        ftv75zFDgC4RVfpjJKl15wvBHzEjZO9ZP+zIFijVLPXwqMehYNvKVYFyIk25+L/kfvDJQZCOnwEjR
        cdDFYVGw==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otgz4-00Daz6-Lg; Sat, 12 Nov 2022 03:15:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH] kernfs: fix all kernel-doc warnings and multiple typos
Date:   Fri, 11 Nov 2022 19:14:56 -0800
Message-Id: <20221112031456.22980-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings. Many of these are about a function's
return value, so use the kernel-doc Return: format to fix those

Use % prefix on numeric constant values.

dir.c: fix typos/spellos
file.c fix typo: s/taret/target/

Fix all of these kernel-doc warnings:

dir.c:305: warning: missing initial short description on line:
 *      kernfs_name_hash

dir.c:137: warning: No description found for return value of 'kernfs_path_from_node_locked'
dir.c:196: warning: No description found for return value of 'kernfs_name'
dir.c:224: warning: No description found for return value of 'kernfs_path_from_node'
dir.c:292: warning: No description found for return value of 'kernfs_get_parent'
dir.c:312: warning: No description found for return value of 'kernfs_name_hash'
dir.c:404: warning: No description found for return value of 'kernfs_unlink_sibling'
dir.c:588: warning: No description found for return value of 'kernfs_node_from_dentry'
dir.c:806: warning: No description found for return value of 'kernfs_find_ns'
dir.c:879: warning: No description found for return value of 'kernfs_find_and_get_ns'
dir.c:904: warning: No description found for return value of 'kernfs_walk_and_get_ns'
dir.c:927: warning: No description found for return value of 'kernfs_create_root'
dir.c:996: warning: No description found for return value of 'kernfs_root_to_node'
dir.c:1016: warning: No description found for return value of 'kernfs_create_dir_ns'
dir.c:1048: warning: No description found for return value of 'kernfs_create_empty_dir'
dir.c:1306: warning: No description found for return value of 'kernfs_next_descendant_post'
dir.c:1568: warning: No description found for return value of 'kernfs_remove_self'
dir.c:1630: warning: No description found for return value of 'kernfs_remove_by_name_ns'
dir.c:1667: warning: No description found for return value of 'kernfs_rename_ns'

file.c:66: warning: No description found for return value of 'of_on'
file.c:88: warning: No description found for return value of 'kernfs_deref_open_node_locked'
file.c:1036: warning: No description found for return value of '__kernfs_create_file'

inode.c:100: warning: No description found for return value of 'kernfs_setattr'

mount.c:160: warning: No description found for return value of 'kernfs_root_from_sb'
mount.c:198: warning: No description found for return value of 'kernfs_node_dentry'
mount.c:302: warning: No description found for return value of 'kernfs_super_ns'
mount.c:318: warning: No description found for return value of 'kernfs_get_tree'

symlink.c:28: warning: No description found for return value of 'kernfs_create_link'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/dir.c             |   82 ++++++++++++++++++++--------------
 fs/kernfs/file.c            |   18 ++++---
 fs/kernfs/inode.c           |    8 +--
 fs/kernfs/kernfs-internal.h |    2 
 fs/kernfs/mount.c           |   10 ++--
 fs/kernfs/symlink.c         |    2 
 6 files changed, 74 insertions(+), 48 deletions(-)

diff -- a/fs/kernfs/dir.c b/fs/kernfs/dir.c
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -125,9 +125,9 @@ static struct kernfs_node *kernfs_common
  * kn_to:   /n1/n2/n3         [depth=3]
  * result:  /../..
  *
- * [3] when @kn_to is NULL result will be "(null)"
+ * [3] when @kn_to is %NULL result will be "(null)"
  *
- * Returns the length of the full path.  If the full length is equal to or
+ * Return: the length of the full path.  If the full length is equal to or
  * greater than @buflen, @buf contains the truncated path with the trailing
  * '\0'.  On error, -errno is returned.
  */
@@ -185,10 +185,12 @@ static int kernfs_path_from_node_locked(
  * @buflen: size of @buf
  *
  * Copies the name of @kn into @buf of @buflen bytes.  The behavior is
- * similar to strlcpy().  It returns the length of @kn's name and if @buf
- * isn't long enough, it's filled upto @buflen-1 and nul terminated.
+ * similar to strlcpy().
  *
- * Fills buffer with "(null)" if @kn is NULL.
+ * Fills buffer with "(null)" if @kn is %NULL.
+ *
+ * Return: the length of @kn's name and if @buf isn't long enough,
+ * it's filled up to @buflen-1 and nul terminated.
  *
  * This function can be called from any context.
  */
@@ -215,7 +217,7 @@ int kernfs_name(struct kernfs_node *kn,
  * path (which includes '..'s) as needed to reach from @from to @to is
  * returned.
  *
- * Returns the length of the full path.  If the full length is equal to or
+ * Return: the length of the full path.  If the full length is equal to or
  * greater than @buflen, @buf contains the truncated path with the trailing
  * '\0'.  On error, -errno is returned.
  */
@@ -287,6 +289,8 @@ out:
  *
  * Determines @kn's parent, pins and returns it.  This function can be
  * called from any context.
+ *
+ * Return: parent node of @kn
  */
 struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
 {
@@ -302,11 +306,11 @@ struct kernfs_node *kernfs_get_parent(st
 }
 
 /**
- *	kernfs_name_hash
+ *	kernfs_name_hash - calculate hash of @ns + @name
  *	@name: Null terminated string to hash
  *	@ns:   Namespace tag to hash
  *
- *	Returns 31 bit hash of ns + name (so it fits in an off_t )
+ *	Return: 31-bit hash of ns + name (so it fits in an off_t)
  */
 static unsigned int kernfs_name_hash(const char *name, const void *ns)
 {
@@ -354,8 +358,8 @@ static int kernfs_sd_compare(const struc
  *	Locking:
  *	kernfs_rwsem held exclusive
  *
- *	RETURNS:
- *	0 on susccess -EEXIST on failure.
+ *	Return:
+ *	%0 on success, -EEXIST on failure.
  */
 static int kernfs_link_sibling(struct kernfs_node *kn)
 {
@@ -394,8 +398,10 @@ static int kernfs_link_sibling(struct ke
  *	@kn: kernfs_node of interest
  *
  *	Try to unlink @kn from its sibling rbtree which starts from
- *	kn->parent->dir.children.  Returns %true if @kn was actually
- *	removed, %false if @kn wasn't on the rbtree.
+ *	kn->parent->dir.children.
+ *
+ *	Return: %true if @kn was actually removed,
+ *	%false if @kn wasn't on the rbtree.
  *
  *	Locking:
  *	kernfs_rwsem held exclusive
@@ -419,10 +425,10 @@ static bool kernfs_unlink_sibling(struct
  *	@kn: kernfs_node to get an active reference to
  *
  *	Get an active reference of @kn.  This function is noop if @kn
- *	is NULL.
+ *	is %NULL.
  *
- *	RETURNS:
- *	Pointer to @kn on success, NULL on failure.
+ *	Return:
+ *	Pointer to @kn on success, %NULL on failure.
  */
 struct kernfs_node *kernfs_get_active(struct kernfs_node *kn)
 {
@@ -442,7 +448,7 @@ struct kernfs_node *kernfs_get_active(st
  *	@kn: kernfs_node to put an active reference to
  *
  *	Put an active reference to @kn.  This function is noop if @kn
- *	is NULL.
+ *	is %NULL.
  */
 void kernfs_put_active(struct kernfs_node *kn)
 {
@@ -464,7 +470,7 @@ void kernfs_put_active(struct kernfs_nod
  * kernfs_drain - drain kernfs_node
  * @kn: kernfs_node to drain
  *
- * Drain existing usages and nuke all existing mmaps of @kn.  Mutiple
+ * Drain existing usages and nuke all existing mmaps of @kn.  Multiple
  * removers may invoke this function concurrently on @kn and all will
  * return after draining is complete.
  */
@@ -577,7 +583,7 @@ EXPORT_SYMBOL_GPL(kernfs_put);
  * kernfs_node_from_dentry - determine kernfs_node associated with a dentry
  * @dentry: the dentry in question
  *
- * Return the kernfs_node associated with @dentry.  If @dentry is not a
+ * Return: the kernfs_node associated with @dentry.  If @dentry is not a
  * kernfs one, %NULL is returned.
  *
  * While the returned kernfs_node will stay accessible as long as @dentry
@@ -684,8 +690,8 @@ struct kernfs_node *kernfs_new_node(stru
  * @id's lower 32bits encode ino and upper gen.  If the gen portion is
  * zero, all generations are matched.
  *
- * RETURNS:
- * NULL on failure. Return a kernfs node with reference counter incremented
+ * Return: %NULL on failure,
+ * otherwise a kernfs node with reference counter incremented.
  */
 struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 						   u64 id)
@@ -733,8 +739,8 @@ err_unlock:
  *	function increments nlink of the parent's inode if @kn is a
  *	directory and link into the children list of the parent.
  *
- *	RETURNS:
- *	0 on success, -EEXIST if entry with the given name already
+ *	Return:
+ *	%0 on success, -EEXIST if entry with the given name already
  *	exists.
  */
 int kernfs_add_one(struct kernfs_node *kn)
@@ -797,8 +803,9 @@ out_unlock:
  * @name: name to look for
  * @ns: the namespace tag to use
  *
- * Look for kernfs_node with name @name under @parent.  Returns pointer to
- * the found kernfs_node on success, %NULL on failure.
+ * Look for kernfs_node with name @name under @parent.
+ *
+ * Return: pointer to the found kernfs_node on success, %NULL on failure.
  */
 static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 					  const unsigned char *name,
@@ -871,8 +878,9 @@ static struct kernfs_node *kernfs_walk_n
  * @ns: the namespace tag to use
  *
  * Look for kernfs_node with name @name under @parent and get a reference
- * if found.  This function may sleep and returns pointer to the found
- * kernfs_node on success, %NULL on failure.
+ * if found.  This function may sleep.
+ *
+ * Return: pointer to the found kernfs_node on success, %NULL on failure.
  */
 struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const char *name, const void *ns)
@@ -896,8 +904,9 @@ EXPORT_SYMBOL_GPL(kernfs_find_and_get_ns
  * @ns: the namespace tag to use
  *
  * Look for kernfs_node with path @path under @parent and get a reference
- * if found.  This function may sleep and returns pointer to the found
- * kernfs_node on success, %NULL on failure.
+ * if found.  This function may sleep.
+ *
+ * Return: pointer to the found kernfs_node on success, %NULL on failure.
  */
 struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 					   const char *path, const void *ns)
@@ -919,7 +928,7 @@ struct kernfs_node *kernfs_walk_and_get_
  * @flags: KERNFS_ROOT_* flags
  * @priv: opaque data associated with the new directory
  *
- * Returns the root of the new hierarchy on success, ERR_PTR() value on
+ * Return: the root of the new hierarchy on success, ERR_PTR() value on
  * failure.
  */
 struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
@@ -991,6 +1000,8 @@ void kernfs_destroy_root(struct kernfs_r
 /**
  * kernfs_root_to_node - return the kernfs_node associated with a kernfs_root
  * @root: root to use to lookup
+ *
+ * Return: @root's kernfs_node
  */
 struct kernfs_node *kernfs_root_to_node(struct kernfs_root *root)
 {
@@ -1007,7 +1018,7 @@ struct kernfs_node *kernfs_root_to_node(
  * @priv: opaque data associated with the new directory
  * @ns: optional namespace tag of the directory
  *
- * Returns the created node on success, ERR_PTR() value on failure.
+ * Return: the created node on success, ERR_PTR() value on failure.
  */
 struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
@@ -1041,7 +1052,7 @@ struct kernfs_node *kernfs_create_dir_ns
  * @parent: parent in which to create a new directory
  * @name: name of the new directory
  *
- * Returns the created node on success, ERR_PTR() value on failure.
+ * Return: the created node on success, ERR_PTR() value on failure.
  */
 struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 					    const char *name)
@@ -1300,6 +1311,8 @@ static struct kernfs_node *kernfs_leftmo
  * Find the next descendant to visit for post-order traversal of @root's
  * descendants.  @root is included in the iteration and the last node to be
  * visited.
+ *
+ * Return: the next descendant to visit or %NULL when done.
  */
 static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 						       struct kernfs_node *root)
@@ -1563,6 +1576,8 @@ void kernfs_unbreak_active_protection(st
  * the whole kernfs_ops which won the arbitration.  This can be used to
  * guarantee, for example, all concurrent writes to a "delete" file to
  * finish only after the whole operation is complete.
+ *
+ * Return: %true if @kn is removed by this call, otherwise %false.
  */
 bool kernfs_remove_self(struct kernfs_node *kn)
 {
@@ -1623,7 +1638,8 @@ bool kernfs_remove_self(struct kernfs_no
  * @ns: namespace tag of the kernfs_node to remove
  *
  * Look for the kernfs_node with @name and @ns under @parent and remove it.
- * Returns 0 on success, -ENOENT if such entry doesn't exist.
+ *
+ * Return: %0 on success, -ENOENT if such entry doesn't exist.
  */
 int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 			     const void *ns)
@@ -1661,6 +1677,8 @@ int kernfs_remove_by_name_ns(struct kern
  * @new_parent: new parent to put @sd under
  * @new_name: new name
  * @new_ns: new namespace tag
+ *
+ * Return: %0 on success, -errno on failure.
  */
 int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		     const char *new_name, const void *new_ns)
diff -- a/fs/kernfs/file.c b/fs/kernfs/file.c
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -33,7 +33,7 @@ struct kernfs_open_node {
  * pending queue is implemented as a singly linked list of kernfs_nodes.
  * The list is terminated with the self pointer so that whether a
  * kernfs_node is on the list or not can be determined by testing the next
- * pointer for NULL.
+ * pointer for %NULL.
  */
 #define KERNFS_NOTIFY_EOL			((void *)&kernfs_notify_list)
 
@@ -59,8 +59,10 @@ static inline struct mutex *kernfs_open_
 }
 
 /**
- * of_on - Return the kernfs_open_node of the specified kernfs_open_file
- * @of: taret kernfs_open_file
+ * of_on - Get the kernfs_open_node of the specified kernfs_open_file
+ * @of: target kernfs_open_file
+ *
+ * Return: the kernfs_open_node of the kernfs_open_file
  */
 static struct kernfs_open_node *of_on(struct kernfs_open_file *of)
 {
@@ -82,6 +84,8 @@ static struct kernfs_open_node *of_on(st
  * outside RCU read-side critical section.
  *
  * The caller needs to make sure that kernfs_open_file_mutex is held.
+ *
+ * Return: @kn->attr.open when kernfs_open_file_mutex is held.
  */
 static struct kernfs_open_node *
 kernfs_deref_open_node_locked(struct kernfs_node *kn)
@@ -548,11 +552,11 @@ out_unlock:
  *	If @kn->attr.open exists, increment its reference count; otherwise,
  *	create one.  @of is chained to the files list.
  *
- *	LOCKING:
+ *	Locking:
  *	Kernel thread context (may sleep).
  *
- *	RETURNS:
- *	0 on success, -errno on failure.
+ *	Return:
+ *	%0 on success, -errno on failure.
  */
 static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
@@ -1024,7 +1028,7 @@ const struct file_operations kernfs_file
  * @ns: optional namespace tag of the file
  * @key: lockdep key for the file's active_ref, %NULL to disable lockdep
  *
- * Returns the created node on success, ERR_PTR() value on error.
+ * Return: the created node on success, ERR_PTR() value on error.
  */
 struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 					 const char *name,
diff -- a/fs/kernfs/inode.c b/fs/kernfs/inode.c
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -94,7 +94,7 @@ int __kernfs_setattr(struct kernfs_node
  * @kn: target node
  * @iattr: iattr to set
  *
- * Returns 0 on success, -errno on failure.
+ * Return: %0 on success, -errno on failure.
  */
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
@@ -239,11 +239,11 @@ static void kernfs_init_inode(struct ker
  *	allocated and basics are initialized.  New inode is returned
  *	locked.
  *
- *	LOCKING:
+ *	Locking:
  *	Kernel thread context (may sleep).
  *
- *	RETURNS:
- *	Pointer to allocated inode on success, NULL on failure.
+ *	Return:
+ *	Pointer to allocated inode on success, %NULL on failure.
  */
 struct inode *kernfs_get_inode(struct super_block *sb, struct kernfs_node *kn)
 {
diff -- a/fs/kernfs/mount.c b/fs/kernfs/mount.c
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -153,7 +153,7 @@ static const struct export_operations ke
  * kernfs_root_from_sb - determine kernfs_root associated with a super_block
  * @sb: the super_block in question
  *
- * Return the kernfs_root associated with @sb.  If @sb is not a kernfs one,
+ * Return: the kernfs_root associated with @sb.  If @sb is not a kernfs one,
  * %NULL is returned.
  */
 struct kernfs_root *kernfs_root_from_sb(struct super_block *sb)
@@ -167,7 +167,7 @@ struct kernfs_root *kernfs_root_from_sb(
  * find the next ancestor in the path down to @child, where @parent was the
  * ancestor whose descendant we want to find.
  *
- * Say the path is /a/b/c/d.  @child is d, @parent is NULL.  We return the root
+ * Say the path is /a/b/c/d.  @child is d, @parent is %NULL.  We return the root
  * node.  If @parent is b, then we return the node for c.
  * Passing in d as @parent is not ok.
  */
@@ -192,6 +192,8 @@ static struct kernfs_node *find_next_anc
  * kernfs_node_dentry - get a dentry for the given kernfs_node
  * @kn: kernfs_node for which a dentry is needed
  * @sb: the kernfs super_block
+ *
+ * Return: the dentry pointer
  */
 struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 				  struct super_block *sb)
@@ -296,7 +298,7 @@ static int kernfs_set_super(struct super
  * kernfs_super_ns - determine the namespace tag of a kernfs super_block
  * @sb: super_block of interest
  *
- * Return the namespace tag associated with kernfs super_block @sb.
+ * Return: the namespace tag associated with kernfs super_block @sb.
  */
 const void *kernfs_super_ns(struct super_block *sb)
 {
@@ -313,6 +315,8 @@ const void *kernfs_super_ns(struct super
  * implementation, which should set the specified ->@fs_type and ->@flags, and
  * specify the hierarchy and namespace tag to mount via ->@root and ->@ns,
  * respectively.
+ *
+ * Return: %0 on success, -errno on failure.
  */
 int kernfs_get_tree(struct fs_context *fc)
 {
diff -- a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -19,7 +19,7 @@
  * @name: name of the symlink
  * @target: target node for the symlink to point to
  *
- * Returns the created node on success, ERR_PTR() value on error.
+ * Return: the created node on success, ERR_PTR() value on error.
  * Ownership of the link matches ownership of the target.
  */
 struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
diff -- a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -58,7 +58,7 @@ struct kernfs_root {
  * kernfs_root - find out the kernfs_root a kernfs_node belongs to
  * @kn: kernfs_node of interest
  *
- * Return the kernfs_root @kn belongs to.
+ * Return: the kernfs_root @kn belongs to.
  */
 static inline struct kernfs_root *kernfs_root(struct kernfs_node *kn)
 {
