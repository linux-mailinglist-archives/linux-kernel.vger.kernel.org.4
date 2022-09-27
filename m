Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A775ECD38
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiI0Tyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiI0Tyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:54:35 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C7FF27
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308471; bh=4oXyPaNUpdf+UlHzcY6z7bvhGz3MAv0OJfHR3VVFtbY=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=sflH5Eewd4sXrvFdI9QgeBElRACiMou+b6sCfnYUh8dheuyZ15Fy8vwstB4dOfm5xDE5bCnQSCFVb6mI2ibNCgGNRCtagQcHs9URtpqkpxbWlzTtT/JSsPUVsJwtcE0jXSTf86ZYr3y47Qhr2ObymN0jKHopdMnXmjWuoBQQSALZ3+wblLUIHcjZwTRHGL7ibMqTPgA9Gt5lhuFYMe3F83uEDGQEAwV7ir/5y7quK1d8JhaCE/JkiZAtqWqwI1ly522GtPTHhkSqZt9ustLra6cjQEpEgBp9rMp0OHGY8xWZc8/4e/URH/MXdNZyRjjEkOUi3GXeyfnHWCugOgGZng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308471; bh=c/NZe+zQ1IyDjcc9Eb6YvvVitZrh8btGiqrp9vPdeUa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fykBCBSKXe2WQpHoJAIEunKJRX8WHwPjAyq8+VPI1C0rIR9cgzY3qz7gdyFQIrjOHDYu/AP8IJhar6qlEQcCWlLSv0W1sGAGP9ZQ6n70IBpzm3q5R5LIFyKcUwztB2yux2Iwu0FQBtA78zmPJNe6jQgQmsNcxVNaMThQt9IZwX/M59tfGpHw9W8wdjUYBc77oUW2291ck22j7dlnTitrxj/nIUxWl4fDS8qxOCtTVoIRxmxZ8Ha01/9kHaab+G+BnJ8dCCymaR3W/aEIOJkU8KqMww85cmSa+SFnPCJz4kJvjDF5jNzfiUNLgoAvGDTXdN8ZvWypgM198JHWgoClQA==
X-YMail-OSG: _HR7HU8VM1lIv4AjjC.slq5El6hTDRjMmp8yNZ5.0t.DtlDEG3kiP4eAwAWdiAb
 .Ss0nu__5JVsqY2Wdcy5HAPclWoo1MFz0e7xhbl.xTMPBsQSitIrLYCZkKG3fM.DGVT_Out.UpaJ
 UYsI4Dj4zeMgDUpD_r7Fz.wwMf40haPU9RDR..NwzPjLqzufxzuG_Ok1rMvaDHeYnb_etq7.0yUA
 nOyG94fvvJ_qOoRKpgSlBxYYhWrlGs8GzCuZor6S9WpTjcEjKf5yqZ8D4OSngehB5bDNMWwMq.ng
 xUGADf57S_fKsM7SORP1Mgi_QNP2PZf4ucivEe5pMZLrmhHdZ8rqfeG9Zx8bpxkv60NYOsQg_Qmf
 QUM0VpVPk4oSEEgcEY63nYT9n58Jor0XFBBRB54HsSbgm8Qj0xEuc_5Mo4Qg9MKy.gC.bDhDn1Ap
 1g5ZMMajXNfTO9HF_UHTAxVsWRH0KyT0CXBE0Ws3KctkoUlX1PRDTnh7MVvO1s7g4jm06zCh770n
 68gGbaCInX7XYHgUnW2SOPECHYm7YbsRdO2tC2xXA9oK1qYTYZk0yTRqhgXUjpsnvhc5.MRJVszN
 iGH08VdnSe6smRhpjsGrRYZx4p9irY_lgb2Ass6AoGXNmqaD4N5ILt5kgqXAR7k_7tBG9u1tlWt8
 tEGaAouiGQ2XM0Ig_rkdXcPQOJg8l36T1dSNMejPYVQdyDMnXEfJcVSC3KREWH1COubj4T6W4W2A
 Jjjo6MT7tYMvmrNiwQybUzf2CJJRTEZVtL_0BJ6lCF8KUIpXa7PQPIogfFLdKr5ue8hSXTJKHUYu
 wc90GcLPUMCghysy6Y.8OYurqWr7rsXaJbVvNR8z548229UF31jFLEH95zXcAL.E_vFfhvpAICu.
 DOLhXRPEoJLW5dBP9GCoiyrizLfs3ZADap7nbDei9dk2a1OhvkSh2dRkDbz903pd34FIHNntijQp
 bQwUV_xiQ9cJS8qp8f6dlpSmbruOPFJwA8LI8703dLZ0bUlPu6UFwNOPRWg5sROLFXu1ncYhhRmo
 LVwpkFnvlGFBfGSc.bEVbO3fe0H54jUHNkbPgwmhQA19CQSjSodid_b02KAblmlU9Vwz.UpJmj.W
 JlqYAos_I264uSKkeqWy3XkM_EGIbc7ffgckQSoWq31vT3bFUzPlhe.n116zGgeL1gQTDItwpiCa
 Md6ylSA92BFNxiLpIvqW2YX7_O3w5.9SaK57h7Wo_.VR.P986UQQ.4NCSTur7l3syjIjptNJtbJK
 .Gc4iJxHWaLITv.ZfRiYMLM6mUqHSK_5ytazVpeaDyeeBUfaNgqBwRdsVGlHeHNtdiLSgQphSMC6
 .3U1f4Yz_m9dZQJSBJ2DFfuYJ2OVG4WKu9kXxiHtGKG.NXyA4L2_tDNR7GDb0J8N8zVWTEOk2z_M
 vrJV8RkFEoMd1HdDIxuEtkiy3fxNdvKTkSPLt3KRmYUdkriQPw.F0cS9LNu3m4NO6bU9hvTkBthr
 UsmnkgegXYRThDq5c.J1enniPYIi9ok8YJ5a8rvnHYuRKRc7GQz67xevnA1trXnn7znXBWfYUjpV
 gCf8LLZw6NEWSrdrnDM6dgLIJ2Vfn4YMc_XM3n6mADZA9Uydan.zQn07nTtbXZ1Hd5OtmVp.NDZ6
 0lCEylXka9r28X7q9bX.hO2LUuBeH7DI1YfEV6X0c.Fbg.5ee27xVZGaF4__1bBp9g1Say8qMcRy
 HYZ5oaQIQz3nEB6VDgBAipaouOhj3uEYPVrsHA5Ytzuo4REy3aCe9lW6PiRJWjPW3ZhPB8r3gDvL
 3dsbfs7Q6bGggDdNJ1u9fBS7JnoufS2_AbUKMPd9HMO.UVpNHviZku6mDsqzrLjlEaTp_0LP66Ii
 IIr_PsB1ttANEPSCfAIthTyNdYFr.nZgtiOc9a9yivfWMLG4YORMs9.du3JBVBUwUeC83KCxDg_4
 UTvTb8yFOTm6FbwdxcgrMKRRKVtyU8HrdFY7OY9AbIjNVV9Uvka2VacZqBhOoEVm0iayaUb4Cl_q
 fQowarUMurUXvBEvFfRlt0Vd61wwsY2PTtcEqgsuJRzRsVoktz7m5dJTA.fhOhJVn_rCoA6fPSVQ
 _i_gywnuAwL3YhKLEjrxv6AraBpKdOwaL6evUDjtt33y_m1__0pOkMMwKV2gcOi.H_Eut0wy_d0f
 Nm_K9a5y_OmAoJcJ987M.XjJltJXxg0mcdKs_hsqo5.sczOJbnn_ZLq7RuFqPn0xfadtD1Bvv_7b
 FfiNmrqpiUL6E7Yo33iiKbWncBxX8TWmfw5P90jrR9NUpXYc5fhkTEHYkOQFJde.4T5KKQWoSk8O
 tI3qPb7iupfSD_BUALMegZQNEZvyMxE4KU5I-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 19:54:31 +0000
Received: by hermes--production-bf1-759bcdd488-njfbl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0b959d6dc02d7e129b663c80c767d31c;
          Tue, 27 Sep 2022 19:54:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 00/39] LSM: Module stacking for AppArmor
Date:   Tue, 27 Sep 2022 12:53:42 -0700
Message-Id: <20220927195421.14713-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20220927195421.14713-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.
There are additional changes required for SELinux and Smack
to coexist. These are primarily in the networking code and
will be addressed after these changes are upstream.

v38: Rebase to 6.0-rc7
     - Discard the implementation of /proc/self/attr/context
     - Discard the implementation of /proc/self/attr/display_lsm
     - Implement a system call lsm_self_attr() which provides
       a complete list of LSM process attributes.
     - Implement a system call lsm_module_list() which provides
       a list of the security modules active on the system.
     - Implement a pair of prctl() options PR_LSM_ATTR_SET
       and PR_LSM_ATTR_GET. These are used to control the LSM
       that provides the values in /proc/.../attr entries.
     - Make more of the infrastructure data changes early in the
       patch set in support of the new system calls.
     - Add a user interface header uapi/linux/lsm.h which contains
       the format of data provided by lsm_self_attr() and the
       integer LSM identifier values.
v37: Rebase to 5.19-rc3
     - Audit changes should be complete, all comments have been
       addressed.
     - Address indexing an empty array for the case where no
       built in security modules require data in struct lsmblob.
     - Fix a few checkpatch complaints.
v36: Rebase to 5.19-rc1
     - Yet another rework of the audit changes. Rearranging how the
       timestamp is managed allows auxiliary records to be generated
       correctly with a minimum of fuss.
     - In the end no LSM interface scaffolding remains. Secids have
       been replaced with lsmblob structures in all cases, including
       IMA and NetLabel.
v35: Rebase to 5.18-rc2
     - Address the case where CONFIG_SECURITY is enabled but
       no security modules that use secid slots are included.
       The resulting blob.secid[0] instances, although never
       present in a call path, raised concerns.
     - Address the case in interface_lsm where the BPF module
       returns -EINVAL, resulting in a failed setting of the
       value that would be otherwise allowed.
v34: Rebase to 5.18-rc1
     - Incorporate feedback on the audit generation.
v33:
     - Rework the supplimental audit record generation once more,
       this time taking pseudo-code provided by Paul Moore as a
       basis. The resulting code is considerably simpler and fits
       better with the existing code flow.
v32: Rebase to 5.17-rc2
     - Incorporate additional feedback from v30.
v31: Rebase to 5.16-rc4
     - Incorporate feedback from Paul Moore on the audit
       component changes.
v30: Rebase to 5.16-rc1
     - Replace the integrity sub-system reuse of the audit
       subsystem event matching functions with IMA specific
       functions. This is done because audit needs to maintain
       information about multiple security modules in audit
       rules while IMA to restricts the information to a single
       security module.
     - The binder hooks have been changed and are no longer
       called with sufficient information to identify the
       interface_lsm. Pass that information in the binder
       message, and use that in the compatibility decision.
     - Refactor the audit changes.
v29: Rebase to 5.15-rc1
     - Rework the supplimental audit record generation. Attach
       a list of supplimental data to the audit_buffer and
       generate the auxiliary records as needed on event end.
       This should be usable for other auxiliary data, such as
       container IDs. There is other ongoing audit work that
       will require integration with this.
v28: Rebase to 5.14-rc2
     - Provide IMA rules bounds checking (patch 04)
     - Quote contexts in MAC_TASK_CONTEXTS and MAC_OBJ_CONTEXTS
       audit records because of AppArmor's use of '=' in context
       values. (patch 22,23)
v27: Fixes for landlock (patch 02)
     - Rework the subject audit record generation. This version is
       simpler and reflects feedback from Paul Moore. (patch 22)
v26: Rebase to 5.13-rc1
     - Include the landlock security module.
     - Accomodate change from security_task_getsecid() to
       security_task_getsecid_obj() and security_task_getsecid_subj().
v25: Rebase to 5.12-rc2
     Incorporate feedback from v24
     - The IMA team suggested improvements to the integrity rule
       processing.
v24: Rebase to 5.11-rc1
     Incorporate feedback from v23
     - Address the IMA team's concerns about "label collisions".
       A label collision occurs when there is ambiguity about
       which of multiple LSMs is being targeted in the definition
       of an integrity check rule.  A system with Smack and
       AppArmor would be unable to distinguish which LSM is
       important to an integrity rule referrencing the label
       "unconfined" as that label is meaningful to both.
       Provide a boot option to specify which LSM will be used in
       IMA rules when multiple LSMs are present. (patch 04)
       Pull LSM "slot" identification from later audit patches in
       in support of this (patch 03).
     - Pick up a few audit events that need to include supplimental
       subject context records that had been missed in the
       previous version.
v23: Rebase to 5.10-rc4
     Incorporate feedback from v22
     - Change /proc/*/attr/display to /proc/*/attr/interface_lsm to
       make the purpose clearer. (patch 0012)
     - Include ABI documentation. (patch 0012, 0022)
     - Introduce LSM documentation updates with the patches where
       the interfaces are added rather than at the end. (patch 0012, 0022)
     Include more maintainers and mail lists in To: and Cc: directives.
v22: Rebase to 5.10-rc1
v21: Rebase to 5.9-rc4
     Incorporate feedback from v20
     - Further revert UDS SO_PEERSEC to use scaffolding around
       the interfaces that use lsmblobs and store only a single
       secid. The possibility of multiple security modules
       requiring data here is still a future problem.
     - Incorporate Richard Guy Briggs' non-syscall auxiliary
       records patch (patch 0019-0021) in place of my "supplimental"
       records implementation. [I'm not sure I've given proper
       attestation. I will correct as appropriate]
v20: Rebase to 5.9-rc1
     Change the BPF security module to use the lsmblob data. (patch 0002)
     Repair length logic in subject label processing (patch 0015)
     Handle -EINVAL from the empty BPF setprocattr hook (patch 0020)
     Correct length processing in append_ctx() (patch 0022)
v19: Rebase to 5.8-rc6
     Incorporate feedback from v18
     - Revert UDS SO_PEERSEC implementation to use lsmblobs
       directly, rather than allocating as needed. The correct
       treatment of out-of-memory conditions in the later case
       is difficult to define. (patch 0005)
     - Use a size_t in append_ctx() (patch 0021)
     - Fix a memory leak when creating compound contexts. (patch 0021)
     Fix build error when CONFIG_SECURITY isn't set (patch 0013)
     Fix build error when CONFIG_SECURITY isn't set (patch 0020)
     Fix build error when CONFIG_SECURITY isn't set (patch 0021)
v18: Rebase to 5.8-rc3
     Incorporate feedback from v17
     - Null pointer checking in UDS (patch 0005)
     Match changes in IMA code (patch 0012)
     Fix the behavior of LSM context supplimental audit
     records so that there's always exactly one when it's
     appropriate for there to be one. This is a substantial
     change that requires extention of the audit_context beyond
     syscall events. (patch 0020)
v17: Rebase to 5.7-rc4
v16: Rebase to 5.6
     Incorporate feedback from v15 - Thanks Stephen, Mimi and Paul
     - Generally improve commit messages WRT scaffolding
     - Comment ima_lsm_isset() (patch 0002)
     - Some question may remain on IMA warning (patch 0002)
     - Mark lsm_slot as __lsm_ro_after_init not __init_data (patch 0002)
     - Change name of lsmblob variable in ima_match_rules() (patch 0003)
     - Instead of putting a struct lsmblob into the unix_skb_parms
       structure put a pointer to an allocated instance. There is
       currently only space for 5 u32's in unix_skb_parms and it is
       likely to get even tighter. Fortunately, the lifecycle
       management of the allocated lsmblob is simple. (patch 0005)
     - Dropped Acks due to the above change (patch 0005)
     - Improved commentary on secmark labeling scaffolding. (patch 0006)
     - Reduced secmark related labeling scaffolding. (patch 0006)
     - Replace use of the zeroth entry of an lsmblob in scaffolding
       with a function lsmblob_value() to hopefully make it less
       obscure. (patch 0006)
     - Convert security_secmark_relabel_packet to use lsmblob as
       this reduces much of the most contentious scaffolding. (patch 0006)
     - Dropped Acks due to the above change (patch 0006)
     - Added BUILD_BUG_ON() for CIPSO tag 6. (patch 0018)
     - Reworked audit subject information. Instead of adding fields in
       the middle of existing records add a new record to the event. When
       a separate record is required use subj="?". (patch 0020)
     - Dropped Acks due to the above change (patch 0020)
     - Reworked audit object information. Instead of adding fields in
       the middle of existing records add a new record to the event. When
       a separate record is required use obj="?". (patch 0021)
     - Dropped Acks due to the above change (patch 0021)
     - Enhanced documentation (patch 0022)
     - Removed unnecessary error code check in security_getprocattr()
       (patch 0021)
v15: Rebase to 5.6-rc1
     - Revise IMA data use (patch 0002)
     Incorporate feedback from v14
     - Fix lockdown module registration naming (patch 0002)
     - Revise how /proc/self/attr/context is gathered. (patch 0022)
     - Revise access modes on /proc/self/attr/context. (patch 0022)
     - Revise documentation on LSM external interfaces. (patch 0022)
v14: Rebase to 5.5-rc5
     Incorporate feedback from v13
     - Use an array of audit rules (patch 0002)
     - Significant change, removed Acks (patch 0002)
     - Remove unneeded include (patch 0013)
     - Use context.len correctly (patch 0015)
     - Reorder code to be more sensible (patch 0016)
     - Drop SO_PEERCONTEXT as it's not needed yet (patch 0023)
v13: Rebase to 5.5-rc2
     Incorporate feedback from v12
     - Print lsmblob size with %z (Patch 0002)
     - Convert lockdown LSM initialization. (Patch 0002)
     - Restore error check in nft_secmark_compute_secid (Patch 0006)
     - Correct blob scaffolding in ima_must_appraise() (Patch 0009)
     - Make security_setprocattr() clearer (Patch 0013)
     - Use lsm_task_display more widely (Patch 0013)
     - Use passed size in lsmcontext_init() (Patch 0014)
     - Don't add a smack_release_secctx() hook (Patch 0014)
     - Don't print warning in security_release_secctx() (Patch 0014)
     - Don't duplicate the label in nfs4_label_init_security() (Patch 0016)
     - Remove reviewed-by as code has significant change (Patch 0016)
     - Send the entire lsmblob for Tag 6 (Patch 0019)
     - Fix description of socket_getpeersec_stream parameters (Patch 0023)
     - Retain LSMBLOB_FIRST. What was I thinking? (Patch 0023)
     - Add compound context to LSM documentation (Patch 0023)
v12: Rebase to 5.5-rc1
     Fixed a couple of incorrect contractions in the text.
v11: Rebase to 5.4-rc6
     Incorporate feedback from v10
     - Disambiguate reading /proc/.../attr/display by restricting
       all use of the interface to the current process.
     - Fix a merge error in AppArmor's display attribute check
v10: Ask the security modules if the display can be changed.
v9: There is no version 9
v8: Incorporate feedback from v7
    - Minor clean-up in display value management
    - refactor "compound" context creation to use a common
      append_ctx() function.
v7: Incorporate feedback from v6
    - Make setting the display a privileged operation. The
      availability of compound contexts reduces the need for
      setting the display.
v6: Incorporate feedback from v5
    - Add subj_<lsm>= and obj_<lsm>= fields to audit records
    - Add /proc/.../attr/context to get the full context in
      lsmname\0value\0... format as suggested by Simon McVittie
    - Add SO_PEERCONTEXT for getsockopt() to get the full context
      in the same format, also suggested by Simon McVittie.
    - Add /sys/kernel/security/lsm_display_default to provide
      the display default value.
v5: Incorporate feedback from v4
    - Initialize the lsmcontext in security_secid_to_secctx()
    - Clear the lsmcontext in all security_release_secctx() cases
    - Don't use the "display" on strictly internal context
      interfaces.
    - The SELinux binder hooks check for cases where the context
      "display" isn't compatible with SELinux.
v4: Incorporate feedback from v3
    - Mark new lsm_<blob>_alloc functions static
    - Replace the lsm and slot fields of the security_hook_list
      with a pointer to a LSM allocated lsm_id structure. The
      LSM identifies if it needs a slot explicitly. Use the
      lsm_id rather than make security_add_hooks return the
      slot value.
    - Validate slot values used in security.c
    - Reworked the "display" process attribute handling so that
      it works right and doesn't use goofy list processing.
    - fix display value check in dentry_init_security
    - Replace audit_log of secids with '?' instead of deleting
      the audit log
v3: Incorporate feedback from v2
    - Make lsmblob parameter and variable names more
      meaningful, changing "le" and "l" to "blob".
    - Improve consistency of constant naming.
    - Do more sanity checking during LSM initialization.
    - Be a bit clearer about what is temporary scaffolding.
    - Rather than clutter security_getpeersec_dgram with
      otherwise unnecessary checks remove the apparmor
      stub, which does nothing useful.

Patch 01 changes the LSM registration interface to pass a
structure lsm_id containing the name of the module instead of
just the LSM name itself.

Patch 02 introduces uapi/linux/lsm.h and numeric LSM identifiers. 
The numeric ID is added to the lsm_id structure.

Patch 03 Adds the information about which process attributes are
supported by each LSM to the lsm_id structure.

Patch 04 introduces a table of LSM attribute data.

Patch 05 changes security_[gs]etprocattr() to use the LSM ID rather
than the LSM name.

Patch 06 implements the lsm_self_attr() system call.

Patch 07 separates the audit rule processing from the
integrity rule processing. They were never really the
same, but void pointers could hide that. The changes
following use the rule pointers differently in audit
and IMA, so keeping the code common is not a good idea.

Patch 08 moves management of the sock security blob
from the individual modules to the infrastructure.

Patches 09-10 introduce a structure "lsmblob" that will gradually
replace the "secid" as a shorthand for security module information.
At this point lsmblob contains an array of u32 secids, one "slot"
for each of the security modules compiled into the kernel that
used secids. A "slot" is allocated when a security module requests
one.

Patch 11 provides mechanism for the IMA subsystem to identify
explicitly which LSM is subject to IMA policy. This includes
a boot option for specifying the default and an additional option
in IMA rules "lsm=".

Patches 12-19 change LSM interfaces to use the lsmblob instead
of secids. It is important that the lsmblob be a fixed size entity
that does not have to be allocated. Several of the places
where it is used would have performance and/or locking
issues with dynamic allocation.

Patch 20 provides a mechanism for a process to identify which
security module's hooks should be used when displaying or
converting a security context string.  A new prctl() options
PR_LSM_ATTR_[GS]ET get and set which security module to show.
Setting the value requires that all modules using the /proc
interfaces allow the transition. The interface LSM of other
processess can be neither read nor written.

Patch 21 Starts the process of changing how a security
context is represented. Since it is possible for a
security context to have been generated by more than one
security module it is now necessary to note which module
created a security context so that the correct "release"
hook can be called. There are several places where the
module that created a security context cannot be inferred.

This is achieved by introducing a "lsmcontext" structure
which contains the context string, its length and the
"slot" number of the security module that created it.
The security_release_secctx() interface is changed,
replacing the (string,len) pointer pair with a lsmcontext
pointer.

Patches 22-25 convert the security interfaces from
(string,len) pointer pairs to a lsmcontext pointer.
The slot number identifying the creating module is
added by the infrastructure. Where the security context
is stored for extended periods the data type is changed.

Patch 26 converts the Netlabel code to save lsmblob structures
instead of secids. This is not strictly necessary as there can
only be one security module that uses Netlabel at this point.
Using a lsmblob is much cleaner, as the interfaces that use the
data have all been converted.

Patch 27 adds checks to the binder hooks which verify
that both ends of a transaction use the same interface LSM.

Patch 28 adds a parameter to security_secid_to_secctx()
that indicates which of the security modules should be used
to provide the context.

Patches 29-33 update the audit system to better handle auxiliary
records. This requires rearranging the timestamp and serial number
handling. The skb pointer used to collect audit data is replaced
by a list of skb pointers.

Patch 34 adds a supplimental audit record for subject
LSM data when there are multiple security modules with such data.
The AUDIT_MAC_TASK_CONTEXTS record is used in conjuction with a
"subj=?" field to identify the subject data. The
AUDIT_MAC_TASK_CONTEXTS record identifies the security module
with the data: subj_selinux=xyz_t subj_apparmor=abc.

An example of the MAC_TASK_CONTEXTS (1420) record is:

    type=UNKNOWN[1420]
    msg=audit(1600880931.832:113)
    subj_apparmor==unconfined
    subj_smack=_

Patch 35 adds a supplimental audit record for object
LSM data when there are multiple security modules with such data.
The AUDIT_MAC_OBJ_CONTEXTS record is used in conjuction The
with a "obj=?" field to identify the object data.
The AUDIT_MAC_OBJ_CONTEXTS record identifies the security module
with the data: obj_selinux="xyz_t obj_apparmor="abc".  While
AUDIT_MAC_TASK_CONTEXTS records will always contain an entry
for each possible security modules, AUDIT_MAC_OBJ_CONTEXTS
records will only contain entries for security modules for
which the object in question has data.

An example of the MAC_OBJ_CONTEXTS (1421) record is:

    type=UNKNOWN[1421]
    msg=audit(1601152467.009:1050):
    obj_selinux=unconfined_u:object_r:user_home_t:s0

Patches 36-37 clean out scaffolding code.

With all interference on the AppArmor hooks removed,
Patch 38 removes the exclusive bit from AppArmor. An unnecessary
stub hook was also removed.

Patch 39 adds a system call lsm_module_list() that provides a set
of integer LSM ID values describing what is active on the system.

The Ubuntu project is using an earlier version of this patchset in
their distribution to enable stacking for containers.

Performance measurements to date have the change within the "noise".
The sockperf and dbench results are on the order of 0.2% to 0.8%
difference, with better performance being as common as worse. The
benchmarks were run with AppArmor and Smack on Ubuntu.

https://github.com/cschaufler/lsm-stacking.git#stack-6.0-rc7-38

Casey Schaufler (39):
  LSM: Identify modules by more than name
  LSM: Add an LSM identifier for external use
  LSM: Identify the process attributes for each module
  LSM: Maintain a table of LSM attribute data
  proc: Use lsmids instead of lsm names for attrs
  LSM: lsm_self_attr syscall for LSM self attributes
  integrity: disassociate ima_filter_rule from security_audit_rule
  LSM: Infrastructure management of the sock security
  LSM: Add the lsmblob data structure.
  LSM: provide lsm name and id slot mappings
  IMA: avoid label collisions with stacked LSMs
  LSM: Use lsmblob in security_audit_rule_match
  LSM: Use lsmblob in security_kernel_act_as
  LSM: Use lsmblob in security_secctx_to_secid
  LSM: Use lsmblob in security_secid_to_secctx
  LSM: Use lsmblob in security_ipc_getsecid
  LSM: Use lsmblob in security_current_getsecid
  LSM: Use lsmblob in security_inode_getsecid
  LSM: Use lsmblob in security_cred_getsecid
  LSM: Specify which LSM to display
  LSM: Ensure the correct LSM context releaser
  LSM: Use lsmcontext in security_secid_to_secctx
  LSM: Use lsmcontext in security_inode_getsecctx
  Use lsmcontext in security_dentry_init_security
  LSM: security_secid_to_secctx in netlink netfilter
  NET: Store LSM netlabel data in a lsmblob
  binder: Pass LSM identifier for confirmation
  LSM: security_secid_to_secctx module selection
  Audit: Keep multiple LSM data in audit_names
  Audit: Create audit_stamp structure
  LSM: Add a function to report multiple LSMs
  Audit: Allow multiple records in an audit_buffer
  Audit: Add record for multiple task security contexts
  audit: multiple subject lsm values for netlabel
  Audit: Add record for multiple object contexts
  netlabel: Use a struct lsmblob in audit data
  LSM: Removed scaffolding function lsmcontext_init
  AppArmor: Remove the exclusive flag
  LSM: Create lsm_module_list system call

 Documentation/ABI/testing/ima_policy    |   8 +-
 arch/x86/entry/syscalls/syscall_64.tbl  |   2 +
 drivers/android/binder.c                |  47 ++-
 drivers/android/binder_internal.h       |   1 +
 fs/ceph/super.h                         |   3 +-
 fs/ceph/xattr.c                         |  15 +-
 fs/fuse/dir.c                           |  35 +-
 fs/nfs/dir.c                            |   2 +-
 fs/nfs/inode.c                          |  17 +-
 fs/nfs/internal.h                       |   8 +-
 fs/nfs/nfs4proc.c                       |  14 +-
 fs/nfs/nfs4xdr.c                        |  22 +-
 fs/nfsd/nfs4xdr.c                       |  20 +-
 fs/proc/base.c                          |  29 +-
 fs/proc/internal.h                      |   2 +-
 include/linux/audit.h                   |  21 +-
 include/linux/cred.h                    |   3 +-
 include/linux/lsm_hooks.h               |  15 +-
 include/linux/nfs4.h                    |   8 +-
 include/linux/nfs_fs.h                  |   2 +-
 include/linux/security.h                | 292 +++++++++++--
 include/linux/syscalls.h                |   2 +
 include/net/netlabel.h                  |  10 +-
 include/net/scm.h                       |  15 +-
 include/uapi/asm-generic/unistd.h       |   8 +-
 include/uapi/linux/audit.h              |   2 +
 include/uapi/linux/lsm.h                |  67 +++
 include/uapi/linux/prctl.h              |   4 +
 kernel/audit.c                          | 261 +++++++++---
 kernel/audit.h                          |  18 +-
 kernel/auditfilter.c                    |  29 +-
 kernel/auditsc.c                        | 160 +++----
 kernel/cred.c                           |  12 +-
 kernel/sys_ni.c                         |   4 +
 net/ipv4/cipso_ipv4.c                   |  26 +-
 net/ipv4/ip_sockglue.c                  |  12 +-
 net/netfilter/nf_conntrack_netlink.c    |  24 +-
 net/netfilter/nf_conntrack_standalone.c |  11 +-
 net/netfilter/nfnetlink_queue.c         |  38 +-
 net/netfilter/nft_meta.c                |  10 +-
 net/netfilter/xt_SECMARK.c              |   7 +-
 net/netlabel/netlabel_kapi.c            |   6 +-
 net/netlabel/netlabel_unlabeled.c       |  98 +++--
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |  10 +-
 net/netlabel/netlabel_user.h            |   2 +-
 security/Makefile                       |   1 +
 security/apparmor/include/apparmor.h    |   3 +-
 security/apparmor/include/net.h         |   6 +-
 security/apparmor/lsm.c                 | 110 ++---
 security/apparmor/net.c                 |   2 +-
 security/bpf/hooks.c                    |  14 +-
 security/commoncap.c                    |   9 +-
 security/integrity/ima/ima.h            |  32 +-
 security/integrity/ima/ima_api.c        |   6 +-
 security/integrity/ima/ima_appraise.c   |  11 +-
 security/integrity/ima/ima_main.c       |  62 +--
 security/integrity/ima/ima_policy.c     |  92 +++-
 security/landlock/cred.c                |   2 +-
 security/landlock/fs.c                  |   2 +-
 security/landlock/ptrace.c              |   2 +-
 security/landlock/setup.c               |   7 +
 security/landlock/setup.h               |   1 +
 security/loadpin/loadpin.c              |  10 +-
 security/lockdown/lockdown.c            |   9 +-
 security/lsm_syscalls.c                 | 206 +++++++++
 security/safesetid/lsm.c                |  10 +-
 security/security.c                     | 539 +++++++++++++++++++++---
 security/selinux/hooks.c                | 115 +++--
 security/selinux/include/classmap.h     |   3 +-
 security/selinux/include/objsec.h       |   5 +
 security/selinux/include/security.h     |   1 +
 security/selinux/netlabel.c             |  25 +-
 security/selinux/ss/services.c          |   4 +-
 security/smack/smack.h                  |   6 +
 security/smack/smack_access.c           |   2 +-
 security/smack/smack_lsm.c              |  85 ++--
 security/smack/smack_netfilter.c        |   4 +-
 security/smack/smackfs.c                |  12 +-
 security/tomoyo/tomoyo.c                |  10 +-
 security/yama/yama_lsm.c                |   9 +-
 81 files changed, 2063 insertions(+), 758 deletions(-)
 create mode 100644 include/uapi/linux/lsm.h
 create mode 100644 security/lsm_syscalls.c

-- 
2.37.3

