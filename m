Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC32694DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjBMRZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjBMRZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:25:42 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBF91D934
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:25:36 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id u3-20020aa78383000000b005a8534314aeso6574410pfm.17
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=brWJOj/V3kO7c4XWKaP2nxoyF0tCzH+Ta9FPHPO/i+4=;
        b=IsiGAgNHg5iWLxfmUX9SOt6ogm2uFvKpnuPo7//3EbDOpD3etPclSuEXfG/iKRu57f
         FNACabvWEXl24SSDPp0zO1o9yoBzMI3hjkqvTWxEFS6yEaKivE9j+E+BbqRfpb1YA5PF
         9WTzAjlRwKm9/v0CN0pdAtsziMDH8seCTFopx2Wum5u6Y1QWbax+Zn1kWqc1KrgPYEz2
         DcA9/Wa03+D3QVkiLrVNvZs4S61IgqFWY7T4l35q/JAH5J2RigCTCWI+2YxLG091WcTr
         OFMMOgaxTDnx5LhcWjWiIfwWSQp5daPKzpbpnBNhtAunLdoOUQiauBhGFavX9fc0mhQk
         mP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brWJOj/V3kO7c4XWKaP2nxoyF0tCzH+Ta9FPHPO/i+4=;
        b=3So/x1qALUq/0bKyPiAAgpO1G85RJ/FvYIoNaTBMoWBW2Ccrd658nBiF+XHCi8pjRk
         rPxV5f2SR694+TW0S1e4IVlu+iexNFHRZ71bvhK49t/FkLWlibawb2WKzeKIhGUY5H1d
         sFqaVc74WHmrVsQlDExiy7ukc8OPCFUKI+TDiS50LB6L1xvU55IjC11gjNTvTdc9WwmP
         2pKcc2TKEF2xKjrKzgdLxwnLER9cI9e6YYzvWL46F0E1LeBjFp/sgiG8tfuD/pTzJr9p
         CokCtRHcMNz4FXP1I2/9w862aRXPI7o0YLuAw4rjvXHZM9FYDntdqMBaf0ngaowt3ERv
         Q7Kg==
X-Gm-Message-State: AO0yUKW8RovJIPUluCxqKq3+JElSErJ7JrTKVvBZlyIPPW+qu2dXxk9X
        B0RymI1nB7gSWz96IXDs0M6U9pqyD22fDW5MM+ST7ASajJC48W9hqU3PU/cp1kib2qSJ+hB2S0q
        sQmiTqiyz0Dfg+3bw4Pyl5rgPmdoXspYdqQ6OX3Ze4zUUghlwD8JCjuhEJEdQpjTbKRUM1ZPq8x
        reaBrbZPw=
X-Google-Smtp-Source: AK7set9tj9X7P/Mpt+PACu0m6ZmTF3MmfSN3AQfkRHvpNKIPD3eAb4vAraHDLMeb7HtRnYBJdJEmmowKhaEzR6HDsQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a63:9206:0:b0:4d9:66d4:d05 with SMTP
 id o6-20020a639206000000b004d966d40d05mr4688957pgd.44.1676309135635; Mon, 13
 Feb 2023 09:25:35 -0800 (PST)
Date:   Mon, 13 Feb 2023 17:25:22 +0000
In-Reply-To: <20230213172525.575766-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230213172525.575766-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213172525.575766-2-dionnaglaze@google.com>
Subject: [PATCH v14 1/3] virt/coco/sev-guest: Add throttling awareness
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host is permitted and encouraged to throttle guest requests to the
AMD-SP since it is a shared resource across all VMs. Without
throttling-awareness, the host returning an error will immediately lock
out access to the VMPCK, which makes the VM less useful as it can't
attest itself. Since throttling is expected for a host to protect itself
from an uncooperative guest, a cooperative host can return a VMM error
code that the request was throttled.

The driver interprets the upper 32 bits of exitinfo2 as a VMM error code.
For safety, since the encryption algorithm in GHCBv2 is AES_GCM, control
must remain in the kernel to complete the request with the current
sequence number. Returning without finishing the request allows the
guest to make another request but with different message contents. This
is IV reuse, and breaks cryptographic protections.

A quick fix is to retry for a while and then disable the VMPCK and
return to user space.

A guest request may not make it to the AMD-SP before the host returns to
the guest, so the err local variable in handle_guest_request must be
initialized the same way fw_err is. snp_issue_guest_request similarly
should set fw_err whether or not the value is non-zero, in order to
appropriately clear the error value when zero.

The IV reuse fix for invalid certs_len needs modification to work with
throttling, since a single retry with a modified exit_code may be
throttled without retry and result in a locked-out VMPCK. Instead,
change the exit_code as before and jump to the same retry label, and
deal with the error code fixup by checking if the exit_code had to be
changed.

Another issue that must be fixed is how crypto results are written to
shared memory. The solution is to double-buffer messages.

The encryption algorithms read and write directly to shared unencrypted
memory, which may leak information as well as permit the host to tamper
with the message integrity. Instead copy whole messages in or out as
needed before doing any computation on them.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <Borislav.Petkov@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Michael Sterritt <sterritt@google.com>

Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request
NAEs")

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev-common.h       |  3 +-
 arch/x86/kernel/sev.c                   |  3 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 54 +++++++++++++++++++++----
 3 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b8357d6ecd47..b63be696b776 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -128,8 +128,9 @@ struct snp_psc_desc {
 	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
 } __packed;
 
-/* Guest message request error code */
+/* Guest message request error codes */
 #define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)
+#define SNP_GUEST_REQ_ERR_BUSY		BIT_ULL(33)
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 679026a640ef..a908ffc2dfba 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2212,14 +2212,13 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (ret)
 		goto e_put;
 
+	*fw_err = ghcb->save.sw_exit_info_2;
 	if (ghcb->save.sw_exit_info_2) {
 		/* Number of expected pages are returned in RBX */
 		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
 		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
 			input->data_npages = ghcb_get_rbx(ghcb);
 
-		*fw_err = ghcb->save.sw_exit_info_2;
-
 		ret = -EIO;
 	}
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4ec4174e05a3..4945f2dd97a2 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -30,6 +30,7 @@
 #define DEVICE_NAME	"sev-guest"
 #define AAD_LEN		48
 #define MSG_HDR_VER	1
+#define ACCEPTABLE_REQUEST_RETRY_DURATION (60*HZ)
 
 struct snp_guest_crypto {
 	struct crypto_aead *tfm;
@@ -43,7 +44,13 @@ struct snp_guest_dev {
 
 	void *certs_data;
 	struct snp_guest_crypto *crypto;
+	/* request and response are in unencrypted memory */
 	struct snp_guest_msg *request, *response;
+	/*
+	 * Avoid information leakage by double-buffering shared messages
+	 * in fields that are in regular encrypted memory.
+	 */
+	struct snp_guest_msg secret_request, secret_response;
 	struct snp_secrets_page_layout *layout;
 	struct snp_req_data input;
 	u32 *os_area_msg_seqno;
@@ -263,14 +270,17 @@ static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
 static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
 {
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_guest_msg *resp = snp_dev->response;
-	struct snp_guest_msg *req = snp_dev->request;
+	struct snp_guest_msg *resp = &snp_dev->secret_response;
+	struct snp_guest_msg *req = &snp_dev->secret_request;
 	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
 	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
 
 	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
 		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
 
+	/* Copy response from shared memory to encrypted memory. */
+	memcpy(resp, snp_dev->response, sizeof(*resp));
+
 	/* Verify that the sequence counter is incremented by 1 */
 	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
 		return -EBADMSG;
@@ -294,7 +304,7 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
 			void *payload, size_t sz)
 {
-	struct snp_guest_msg *req = snp_dev->request;
+	struct snp_guest_msg *req = &snp_dev->secret_request;
 	struct snp_guest_msg_hdr *hdr = &req->hdr;
 
 	memset(req, 0, sizeof(*req));
@@ -322,22 +332,34 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *fw_err)
 {
-	unsigned long err;
+	unsigned long err = 0xff;
+	unsigned long start_time = jiffies;
+	u64 orig_exit_code = exit_code;
 	u64 seqno;
 	int rc;
+	unsigned int certs_npages = 0;
 
 	/* Get message sequence and verify that its a non-zero */
 	seqno = snp_get_msg_seqno(snp_dev);
 	if (!seqno)
 		return -EIO;
 
+	/* Clear shared memory's response for the host to populate. */
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
-	/* Encrypt the userspace provided payload */
+	/* Encrypt the userspace provided payload in snp_dev->secret_request. */
 	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
 	if (rc)
 		return rc;
 
+	/*
+	 * Write the fully encrypted request to the shared unencrypted
+	 * request page.
+	 */
+	memcpy(snp_dev->request, &snp_dev->secret_request,
+	       sizeof(snp_dev->secret_request));
+
+retry:
 	/*
 	 * Call firmware to process the request. In this function the encrypted
 	 * message enters shared memory with the host. So after this call the
@@ -346,6 +368,20 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 */
 	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
 
+	/*
+	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
+	 * throttled. Retry in the driver to avoid returning and reusing the
+	 * message sequence number on a different message.
+	 */
+	if (err == SNP_GUEST_REQ_ERR_BUSY) {
+		if (jiffies - start_time > ACCEPTABLE_REQUEST_RETRY_DURATION) {
+			rc = -ETIMEDOUT;
+			goto disable_vmpck;
+		}
+		cond_resched();
+		goto retry;
+	}
+
 	/*
 	 * If the extended guest request fails due to having too small of a
 	 * certificate data buffer, retry the same guest request without the
@@ -354,7 +390,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 */
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
 	    err == SNP_GUEST_REQ_INVALID_LEN) {
-		const unsigned int certs_npages = snp_dev->input.data_npages;
+		certs_npages = snp_dev->input.data_npages;
 
 		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
 
@@ -366,8 +402,12 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		 * of the VMPCK and the error code being propagated back to the
 		 * user as an ioctl() return code.
 		 */
-		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+		cond_resched();
+		goto retry;
 
+	}
+	if (orig_exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
+	    exit_code != orig_exit_code) {
 		/*
 		 * Override the error to inform callers the given extended
 		 * request buffer size was too small and give the caller the
-- 
2.39.1.581.gbfd45094c4-goog

