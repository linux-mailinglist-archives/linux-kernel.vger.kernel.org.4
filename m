Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2DC5F0C59
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiI3NVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiI3NVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:21:36 -0400
X-Greylist: delayed 6954 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Sep 2022 06:21:34 PDT
Received: from 16.mo550.mail-out.ovh.net (16.mo550.mail-out.ovh.net [178.33.104.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41146EEB67
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:21:33 -0700 (PDT)
Received: from player787.ha.ovh.net (unknown [10.110.103.226])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 63B0724E3A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:21:32 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player787.ha.ovh.net (Postfix) with ESMTPSA id B81F72F617DDE;
        Fri, 30 Sep 2022 13:21:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-98R002a2895fbf-d927-406b-828b-46aab43055c6,
                    C05B2F2BD13FA39C9993548B485976379164E02D) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     David Howells <dhowells@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>
Subject: [PATCH] docs: update flexible arrays to match code
Date:   Fri, 30 Sep 2022 15:20:42 +0200
Message-Id: <20220930132042.207776-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17103545488890496755
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepleegteeujeffjeefjeevhfdtudefjefgteelgedtudekleeiledvvdetudevjedtnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the docs to replace zero-length arrays with flexible arrays,
where such changes have been made in the actual implementation. This
ensures that the documentation matches the code, and will hopefully
reduce the risk of new uses of zero-length arrays.

For RxRPC, struct rxrpc_key_sec2_v1 is, as far as I can tell, really
struct rxrpc_key_data_v1 in the implementation.

Signed-off-by: Stephen Kitt <steve@sk2.org>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 Documentation/bpf/btf.rst              |  2 +-
 Documentation/dev-tools/kcov.rst       |  2 +-
 Documentation/driver-api/connector.rst |  2 +-
 Documentation/driver-api/usb/URB.rst   |  2 +-
 Documentation/filesystems/fiemap.rst   |  2 +-
 Documentation/locking/hwspinlock.rst   |  2 +-
 Documentation/networking/can.rst       |  2 +-
 Documentation/networking/rxrpc.rst     |  7 +++----
 Documentation/security/digsig.rst      |  4 ++--
 Documentation/staging/remoteproc.rst   |  4 ++--
 Documentation/virt/kvm/api.rst         | 26 +++++++++++++-------------
 Documentation/x86/boot.rst             |  4 ++--
 12 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index cf8722f96090..c853d49b3f8b 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -766,7 +766,7 @@ func_info for each specific ELF section.::
         __u32   sec_name_off; /* offset to section name */
         __u32   num_info;
         /* Followed by num_info * record_size number of bytes */
-        __u8    data[0];
+        __u8    data[];
      };
 
 Here, num_info must be greater than 0.
diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index d83c9ab49427..942135862d1e 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -261,7 +261,7 @@ selectively from different subsystems.
 	__u32		area_size;
 	__u32		num_handles;
 	__aligned_u64	common_handle;
-	__aligned_u64	handles[0];
+	__aligned_u64	handles[];
     };
 
     #define KCOV_INIT_TRACE			_IOR('c', 1, unsigned long)
diff --git a/Documentation/driver-api/connector.rst b/Documentation/driver-api/connector.rst
index 631b84a48aa5..c00416e5fe98 100644
--- a/Documentation/driver-api/connector.rst
+++ b/Documentation/driver-api/connector.rst
@@ -50,7 +50,7 @@ be dereferenced to `struct cn_msg *`::
 
 	__u16			len;	/* Length of the following data */
 	__u16			flags;
-	__u8			data[0];
+	__u8			data[];
   };
 
 Connector interfaces
diff --git a/Documentation/driver-api/usb/URB.rst b/Documentation/driver-api/usb/URB.rst
index a182c0f5e38a..7b97bb2b3ff4 100644
--- a/Documentation/driver-api/usb/URB.rst
+++ b/Documentation/driver-api/usb/URB.rst
@@ -82,7 +82,7 @@ Some of the fields in struct urb are::
 
     // ISO only: packets are only "best effort"; each can have errors
 	int error_count;                // number of errors
-	struct usb_iso_packet_descriptor iso_frame_desc[0];
+	struct usb_iso_packet_descriptor iso_frame_desc[];
   };
 
 Your driver must create the "pipe" value using values from the appropriate
diff --git a/Documentation/filesystems/fiemap.rst b/Documentation/filesystems/fiemap.rst
index 93fc96f760aa..8c4693f370db 100644
--- a/Documentation/filesystems/fiemap.rst
+++ b/Documentation/filesystems/fiemap.rst
@@ -24,7 +24,7 @@ A fiemap request is encoded within struct fiemap::
 				    * mapped (out) */
 	__u32	fm_extent_count; /* size of fm_extents array (in) */
 	__u32	fm_reserved;
-	struct fiemap_extent fm_extents[0]; /* array of mapped extents (out) */
+	struct fiemap_extent fm_extents[]; /* array of mapped extents (out) */
   };
 
 
diff --git a/Documentation/locking/hwspinlock.rst b/Documentation/locking/hwspinlock.rst
index 6f03713b7003..a37e7c24ff26 100644
--- a/Documentation/locking/hwspinlock.rst
+++ b/Documentation/locking/hwspinlock.rst
@@ -439,7 +439,7 @@ implementation using the hwspin_lock_register() API.
 		const struct hwspinlock_ops *ops;
 		int base_id;
 		int num_locks;
-		struct hwspinlock lock[0];
+		struct hwspinlock lock[];
 	};
 
 struct hwspinlock_device contains an array of hwspinlock structs, each
diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index ebc822e605f5..9ac6d3973ad5 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -740,7 +740,7 @@ The broadcast manager sends responses to user space in the same form:
             struct timeval ival1, ival2;    /* count and subsequent interval */
             canid_t can_id;                 /* unique can_id for task */
             __u32 nframes;                  /* number of can_frames following */
-            struct can_frame frames[0];
+            struct can_frame frames[];
     };
 
 The aligned payload 'frames' uses the same basic CAN frame structure defined
diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index 39494a6ea739..c4a438f26a3b 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -511,14 +511,13 @@ found at:
 The payload provided to add_key() on the client should be of the following
 form::
 
-	struct rxrpc_key_sec2_v1 {
+	struct rxrpc_key_data_v1 {
 		uint16_t	security_index;	/* 2 */
 		uint16_t	ticket_length;	/* length of ticket[] */
 		uint32_t	expiry;		/* time at which expires */
-		uint8_t		kvno;		/* key version number */
-		uint8_t		__pad[3];
+		uint32_t	kvno;		/* key version number */
 		uint8_t		session_key[8];	/* DES session key */
-		uint8_t		ticket[0];	/* the encrypted ticket */
+		uint8_t		ticket[];	/* the encrypted ticket */
 	};
 
 Where the ticket blob is just appended to the above structure.
diff --git a/Documentation/security/digsig.rst b/Documentation/security/digsig.rst
index f6a8902d3ef7..d7479f98a27e 100644
--- a/Documentation/security/digsig.rst
+++ b/Documentation/security/digsig.rst
@@ -31,7 +31,7 @@ Public key and signature consist of header and MPIs::
 		time_t		timestamp;	/* key made, always 0 for now */
 		uint8_t		algo;
 		uint8_t		nmpi;
-		char		mpi[0];
+		char		mpi[];
 	} __packed;
 
 	struct signature_hdr {
@@ -41,7 +41,7 @@ Public key and signature consist of header and MPIs::
 		uint8_t		hash;
 		uint8_t		keyid[8];
 		uint8_t		nmpi;
-		char		mpi[0];
+		char		mpi[];
 	} __packed;
 
 keyid equals to SHA1[12-19] over the total key content.
diff --git a/Documentation/staging/remoteproc.rst b/Documentation/staging/remoteproc.rst
index 348ee7e508ac..fc7e5a75db8e 100644
--- a/Documentation/staging/remoteproc.rst
+++ b/Documentation/staging/remoteproc.rst
@@ -275,7 +275,7 @@ The resource table begins with this header::
 	u32 ver;
 	u32 num;
 	u32 reserved[2];
-	u32 offset[0];
+	u32 offset[];
   } __packed;
 
 Immediately following this header are the resource entries themselves,
@@ -292,7 +292,7 @@ each of which begins with the following resource entry header::
    */
   struct fw_rsc_hdr {
 	u32 type;
-	u8 data[0];
+	u8 data[];
   } __packed;
 
 Some resources entries are mere announcements, where the host is informed
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index abd7c32126ce..a5295b0716d6 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -206,7 +206,7 @@ Errors:
 
   struct kvm_msr_list {
 	__u32 nmsrs; /* number of msrs in entries */
-	__u32 indices[0];
+	__u32 indices[];
   };
 
 The user fills in the size of the indices array in nmsrs, and in return
@@ -654,7 +654,7 @@ be obtained using KVM_GET_MSR_INDEX_LIST in a system ioctl.
 	__u32 nmsrs; /* number of msrs in entries */
 	__u32 pad;
 
-	struct kvm_msr_entry entries[0];
+	struct kvm_msr_entry entries[];
   };
 
   struct kvm_msr_entry {
@@ -726,7 +726,7 @@ Caveat emptor:
   struct kvm_cpuid {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry entries[0];
+	struct kvm_cpuid_entry entries[];
   };
 
 
@@ -752,7 +752,7 @@ signal mask.
   /* for KVM_SET_SIGNAL_MASK */
   struct kvm_signal_mask {
 	__u32 len;
-	__u8  sigset[0];
+	__u8  sigset[];
   };
 
 
@@ -1610,7 +1610,7 @@ otherwise it will return EBUSY error.
 
   struct kvm_xsave {
 	__u32 region[1024];
-	__u32 extra[0];
+	__u32 extra[];
   };
 
 This ioctl would copy current vcpu's xsave struct to the userspace.
@@ -1630,7 +1630,7 @@ This ioctl would copy current vcpu's xsave struct to the userspace.
 
   struct kvm_xsave {
 	__u32 region[1024];
-	__u32 extra[0];
+	__u32 extra[];
   };
 
 This ioctl would copy userspace's xsave struct to the kernel. It copies
@@ -1712,7 +1712,7 @@ This ioctl would set vcpu's xcr to the value userspace specified.
   struct kvm_cpuid2 {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry2 entries[0];
+	struct kvm_cpuid_entry2 entries[];
   };
 
   #define KVM_CPUID_FLAG_SIGNIFCANT_INDEX		BIT(0)
@@ -1837,7 +1837,7 @@ On arm64, GSI routing has the following limitation:
   struct kvm_irq_routing {
 	__u32 nr;
 	__u32 flags;
-	struct kvm_irq_routing_entry entries[0];
+	struct kvm_irq_routing_entry entries[];
   };
 
 No flags are specified so far, the corresponding field must be set to zero.
@@ -3532,7 +3532,7 @@ Errors:
 
   struct kvm_reg_list {
 	__u64 n; /* number of registers in reg[] */
-	__u64 reg[0];
+	__u64 reg[];
   };
 
 This ioctl returns the guest registers that are supported for the
@@ -3683,7 +3683,7 @@ structure containing architecture specific debug information.
   struct kvm_cpuid2 {
 	__u32 nent;
 	__u32 flags;
-	struct kvm_cpuid_entry2 entries[0];
+	struct kvm_cpuid_entry2 entries[];
   };
 
 The member 'flags' is used for passing flags from userspace.
@@ -4921,7 +4921,7 @@ that KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 is present.
   struct kvm_cpuid2 {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry2 entries[0];
+	struct kvm_cpuid_entry2 entries[];
   };
 
   struct kvm_cpuid_entry2 {
@@ -5037,7 +5037,7 @@ using this ioctl.
 	__u32 fixed_counter_bitmap;
 	__u32 flags;
 	__u32 pad[4];
-	__u64 events[0];
+	__u64 events[];
   };
 
 This ioctl restricts the set of PMU events that the guest can program.
@@ -5906,7 +5906,7 @@ as the descriptors in Descriptors block.
 
   struct kvm_xsave {
 	__u32 region[1024];
-	__u32 extra[0];
+	__u32 extra[];
   };
 
 This ioctl would copy current vcpu's xsave struct to the userspace. It
diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 894a19897005..b2782386f39d 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -805,13 +805,13 @@ Protocol:	2.09+
   The 64-bit physical pointer to NULL terminated single linked list of
   struct setup_data. This is used to define a more extensible boot
   parameters passing mechanism. The definition of struct setup_data is
-  as follow::
+  as follows::
 
 	struct setup_data {
 		u64 next;
 		u32 type;
 		u32 len;
-		u8  data[0];
+		u8  data[];
 	};
 
   Where, the next is a 64-bit physical pointer to the next node of

base-commit: a1375562c0a87f0fa2eaf3e8ce15824696d4170a
-- 
2.30.2

