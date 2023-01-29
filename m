Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C806802DA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjA2XLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjA2XLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:11:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8DE1ABF1;
        Sun, 29 Jan 2023 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Oaf2GHg+K6yqAp4oy5GEue7tbGWiGoC46Ts2HOLxmEU=; b=sjYNpeHyRh7Oz7kQ5QXoHI8qcX
        XN5SUVg3f3MG8/ylkBY8ZPuBhZOgJpxD9wYaSKfJ6Jv7MHr2lAJSTnKz//PAAsj44GbIEA7OhBJLq
        YDnF/x+iOVpE6D4hJ8LTlNL7cijnceDhbkT2XgTbkRWOclGQqRq7L7k9erzUsaMopBSWicStYY0Wc
        IOxKN9F1Oyr4A3H2oHkvOZioS5D74DKlDuwWEBpY6RHuS/w0lMZQkPLK42iclTwzQAX6CEP+Xpzac
        mnQfMIu/dHPHCBODorc6CcvfvIspO2AR3VB3PGYFrtZZqmsukJeir5iON9XPtcsyHGxXBcT9evfwt
        nCt7HN/w==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMGpA-0020M2-6u; Sun, 29 Jan 2023 23:11:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 6/9] Documentation: scsi/ChangeLog*: correct spelling
Date:   Sun, 29 Jan 2023 15:10:50 -0800
Message-Id: <20230129231053.20863-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129231053.20863-1-rdunlap@infradead.org>
References: <20230129231053.20863-1-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/scsi/ ChangeLogs
as reported by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
 Documentation/scsi/ChangeLog.lpfc         |   36 ++++++++++----------
 Documentation/scsi/ChangeLog.megaraid     |    8 ++--
 Documentation/scsi/ChangeLog.megaraid_sas |    4 +-
 Documentation/scsi/ChangeLog.ncr53c8xx    |   16 ++++----
 Documentation/scsi/ChangeLog.sym53c8xx    |   14 +++----
 Documentation/scsi/ChangeLog.sym53c8xx_2  |   10 ++---
 6 files changed, 44 insertions(+), 44 deletions(-)

diff -- a/Documentation/scsi/ChangeLog.lpfc b/Documentation/scsi/ChangeLog.lpfc
--- a/Documentation/scsi/ChangeLog.lpfc
+++ b/Documentation/scsi/ChangeLog.lpfc
@@ -174,7 +174,7 @@ Changes from 20050201 to 20050208
 	  lpfc_sli_chipset_init static.
 	* Cleaned up references to list_head->next field in the driver.
 	* Replaced lpfc_discq_post_event with lpfc_workq_post_event.
-	* Implmented Christoph Hellwig's review from 2/5: Check for return
+	* Implemented Christoph Hellwig's review from 2/5: Check for return
 	  values of kmalloc.
 	* Integrated Christoph Hellwig's patch from 1/30: Protecting
 	  scan_tmo and friends in !FC_TRANSPORT_PATCHES_V2 &&
@@ -182,7 +182,7 @@ Changes from 20050201 to 20050208
 	* Integrated Christoph Hellwig's patch from 1/30: Some fixes in
 	  the evt handling area.
 	* Integrated Christoph Hellwig's patch from 1/30: Remove usage of
-	  intr_inited variable. The interrupt initilization from OS side
+	  intr_inited variable. The interrupt initialization from OS side
 	  now happens in lpfc_probe_one().
 	* Integrated Christoph Hellwig's patch from 1/30: remove shim
 	  lpfc_alloc_transport_attr - remove shim lpfc_alloc_shost_attrs -
@@ -389,7 +389,7 @@ Changes from 20041220 to 20041229
 	  moved to kthread. kthread_stop() is not able to wake up thread
 	  waiting on a semaphore and "modprobe -r lpfc" is not always
 	  (most of the times) able to complete. Fix is in not using
-	  semaphore for the interruptable sleep.
+	  semaphore for the interruptible sleep.
 	* Small Makefile cleanup - Remove remnants of 2.4 vs. 2.6
 	  determination.
 
@@ -439,8 +439,8 @@ Changes from 20041207 to 20041213
 	  hardware actually found).
 	* Integrate Christoph Hellwig's patch for 8.0.14: Add missing
 	  __iomem annotations, remove broken casts, mark functions static.
-	  Only major changes is chaning of some offsets from word-based to
-	  byte-based so we cans simply do void pointer arithmetics (gcc
+	  Only major changes is changing of some offsets from word-based to
+	  byte-based so we can simply do void pointer arithmetic (gcc
 	  extension) instead of casting to uint32_t.
 	* Integrate Christoph Hellwig's patch for 8.0.14: flag is always
 	  LPFC_SLI_ABORT_IMED, aka 0 - remove dead code.
@@ -515,7 +515,7 @@ Changes from 20041018 to 20041123
 	  a result of removing from the txcmpl list item which was already
 	  removed (100100 is a LIST_POISON1 value from the next pointer
 	  and 8 is an offset of the "prev") Driver runs out of iotags and
-	  does not handle that case well. The root of the proble is in the
+	  does not handle that case well. The root of the problem is in the
 	  initialization code in lpfc_sli.c
 	* Changes to work with proposed linux kernel patch to support
 	  hotplug.
@@ -570,8 +570,8 @@ Changes from 20041018 to 20041123
 	  associated I/Os to complete before returning.
 	* Fix memset byte count in lpfc_hba_init so that
 	  LP1050 would initialize correctly.
-	* Backround nodev_timeout processing to DPC This enables us to
-	  unblock (stop dev_loss_tmo) when appopriate.
+	* Background nodev_timeout processing to DPC. This enables us to
+	  unblock (stop dev_loss_tmo) when appropriate.
 	* Fix array discovery with multiple luns.  The max_luns was 0 at
 	  the time the host structure was initialized.  lpfc_cfg_params
 	  then set the max_luns to the correct value afterwards.
@@ -1012,7 +1012,7 @@ Changes from 20040614 to 20040709
 	  LINK_[UP|DOWN] and RSCN events.
 	* Get rid of delay_iodone timer.
 	* Remove qfull timers and qfull logic.
-	* Convert mbox_tmo, nlp_xri_tmo to 1 argment clock handler
+	* Convert mbox_tmo, nlp_xri_tmo to 1 argument clock handler
 	* Removed duplicate extern defs of the bind variables.
 	* Streamline usage of the defines CLASS2 and CLASS3, removing
 	  un-necessary checks on config[LPFC_CFG_FCP_CLASS].
@@ -1369,7 +1369,7 @@ Changes from 20040416 to 20040426
 	* Removed lpfc_max_target from lpfc_linux_attach
 	* Replace references to lpfcDRVR.pHba[] with lpfc_get_phba_by_inst()
 	* Change lpfc_param to lpfc-param
-	* Partially removed 32 HBA restriction within driver.  Incorported
+	* Partially removed 32 HBA restriction within driver.  Incorporated
 	  lpfc_instcnt, lpfc_instance[], and pHba[] into lpfcDRVR
 	  structure Added routines lpfc_get_phba_by_inst()
 	  lpfc_get_inst_by_phba() lpfc_check_valid_phba()
@@ -1535,7 +1535,7 @@ Changes from 20040326 to 20040402
 	* Use Linux list macros for DMABUF_t
 	* Break up ioctls into 3 sections, dfc, util, hbaapi
 	  rearranged code so this could be easily separated into a
-	  differnet module later All 3 are currently turned on by
+	  different module later. All 3 are currently turned on by
 	  defines in lpfc_ioctl.c LPFC_DFC_IOCTL, LPFC_UTIL_IOCTL,
 	  LPFC_HBAAPI_IOCTL
 	* Misc cleanup: some goto's; add comments; clarify function
@@ -1562,7 +1562,7 @@ Changes from 20040326 to 20040402
 	* Remove unused log message.
 	* Collapse elx_crtn.h and prod_crtn.h into lpfc_crtn.h
 	* Ifdef Scheduler specific routines
-	* Removed following ununsed ioclt's: ELX_READ_IOCB
+	* Removed following unused ioctl's: ELX_READ_IOCB
 	  ELX_READ_MEMSEG ELX_READ_BINFO ELX_READ_EINVAL ELX_READ_LHBA
 	  ELX_READ_LXHBA ELX_SET ELX_DBG LPFC_TRACE 
 	* Removed variable fc_dbg_flg
@@ -1570,7 +1570,7 @@ Changes from 20040326 to 20040402
 	  3-digit HBAs.  Also changed can_queue so midlayer will only
 	  send (HBA_Q_DEPTH - 10) cmds.
 	* Clean up code in the error path, check condition.  Remove
-	  ununsed sense-related fields in lun structure.
+	  unused sense-related fields in lun structure.
 	* Added code for safety pools for following objects: mbuf/bpl,
 	  mbox, iocb, ndlp, bind
 	* Wrapped '#include <elx_sched.h>' in '#ifdef USE_SCHEDULER'.
@@ -1592,7 +1592,7 @@ Changes from 20040326 to 20040402
 	  ELX_READ_HBA ELX_INSTANCE ELX_LIP.  Also introduced
 	  attribute "set" to be used in conjunction with the above
 	  attributes.
-	* Removed DLINK, enque and deque declarations now that clock
+	* Removed DLINK, enqueue and dequeue declarations now that clock
 	  doesn't use them anymore
 	* Separated install rule so that BUILD_IPFC has to be set when
 	  make is called in order for the install rule to attempt to
@@ -1662,7 +1662,7 @@ Changes from 20040326 to 20040402
 	* Create utility clock function elx_start_timer() and
 	  elx_stop_timer().  All timeout routines now use these common
 	  routines.
-	* Minor formating changes fix up comments
+	* Minor formatting changes fix up comments
 	* Minor formatting changes get rid of failover defines for
 	  syntax checking
 	* Minor formatting changes remove ISCSI defines.
@@ -1676,7 +1676,7 @@ Changes from 20040326 to 20040402
 	  will not exist otherwise.
 	* Removed unused malloc counters from lpfcLINUXfcp.c.
 	* Remove some unnecessary #includes in lpfcLINUXfcp.c
-	* Remove unncessary #includes in elxLINUXfcp.c
+	* Remove unnecessary #includes in elxLINUXfcp.c
 	* Minor formatting cleanups in Makefile to avoid some
           linewrapping.
 	* Removed unused elx_mem_pool data structure.
@@ -1753,7 +1753,7 @@ Changes from 20040319 to 20040326
 	  elx_str_atox).
 	* Replaced DLINK_t and SLINK_t by standard Linux list_head
 	* Removed deque macro
-	* Replaced ELX_DLINK_t ans ELX_SLINK_t by Linux struct list_head
+	* Replaced ELX_DLINK_t and ELX_SLINK_t by Linux struct list_head
 	  (except for clock)
 	* Removed following functions from code: linux_kmalloc linux_kfree
 	  elx_alloc_bigbuf elx_free_bigbuf
@@ -1801,7 +1801,7 @@ Changes from 20040312 to 20040319
 	* Correct Iocbq completion routine for 2.6 kernel case
 	* Change void *pOSCmd to Scsi_Smnd *pCmd
 	* Change void *pOScmd to struct sk_buff *pCmd
-	* Remove data directon code.
+	* Remove data direction code.
 	* Removed memory pool for buf/bpl buffers and use kmalloc/kfree
 	  pci_pool_alloc/free directly.
 	* Move PPC check for DMA address 0 in scatter-gather list, into
diff -- a/Documentation/scsi/ChangeLog.megaraid b/Documentation/scsi/ChangeLog.megaraid
--- a/Documentation/scsi/ChangeLog.megaraid
+++ b/Documentation/scsi/ChangeLog.megaraid
@@ -22,7 +22,7 @@ Older Version	: 2.20.4.8 (scsi module),
 	Customer reported "garbage in file on x86_64 platform".
 	Root Cause: the driver registered controllers as 64-bit DMA capable
 	for those which are not support it.
-	Fix: Made change in the function inserting identification machanism
+	Fix: Made change in the function inserting identification mechanism
 	identifying 64-bit DMA capable controllers.
 
 	> -----Original Message-----
@@ -82,9 +82,9 @@ Older Version	: 2.20.4.8 (scsi module),
 	Fix: MegaRAID F/W has fixed the problem and being process of release,
 	soon. Meanwhile, driver will filter out the request.
 
-3.	One of member in the data structure of the driver leads unaligne
+3.	One member in the data structure of the driver leads to unaligned
 	issue on 64-bit platform.
-	Customer reporeted "kernel unaligned access addrss" issue when
+	Customer reported "kernel unaligned access address" issue when
 	application communicates with MegaRAID HBA driver.
 	Root Cause: in uioc_t structure, one of member had misaligned and it
 	led system to display the error message.
@@ -441,7 +441,7 @@ i.	When copying the mailbox packets, cop
 	avoid getting the stale values for busy bit. We want to set the busy
 	bit just before issuing command to the FW.
 
-ii.	In the reset handling, if the reseted command is not owned by the
+ii.	In the reset handling, if the reset command is not owned by the
 	driver, do not (wrongly) print information for the "attached" driver
 	packet.
 
diff -- a/Documentation/scsi/ChangeLog.megaraid_sas b/Documentation/scsi/ChangeLog.megaraid_sas
--- a/Documentation/scsi/ChangeLog.megaraid_sas
+++ b/Documentation/scsi/ChangeLog.megaraid_sas
@@ -517,7 +517,7 @@ i.	bios_param entry added in scsi_host_t
 
 1. Added new memory management module to support the IOCTL memory allocation. For IOCTL we try to allocate from the memory pool created during driver initialization. If mem pool is empty then we allocate at run time.
 2. Added check in megasas_queue_command and dpc/isr routine to see if we have already declared adapter dead
-   (hw_crit_error=1). If hw_crit_error==1, now we donot accept any processing of pending cmds/accept any cmd from OS
+   (hw_crit_error=1). If hw_crit_error==1, now we do not accept any processing of pending cmds/accept any cmd from OS
 
 1 Release Date    : Mon Oct 02 11:21:32 PDT 2006 - Sumant Patro <Sumant.Patro@lsil.com>
 2 Current Version : 00.00.03.05
@@ -562,7 +562,7 @@ vii.	Added print : FW now in Ready State
 2 Current Version : 00.00.03.02
 3 Older Version   : 00.00.03.01
 
-i.	Added FW tranistion state for Hotplug scenario
+i.	Added FW transition state for Hotplug scenario
 
 1 Release Date    : Sun May 14 22:49:52 PDT 2006 - Sumant Patro <Sumant.Patro@lsil.com>
 2 Current Version : 00.00.03.01
diff -- a/Documentation/scsi/ChangeLog.ncr53c8xx b/Documentation/scsi/ChangeLog.ncr53c8xx
--- a/Documentation/scsi/ChangeLog.ncr53c8xx
+++ b/Documentation/scsi/ChangeLog.ncr53c8xx
@@ -230,7 +230,7 @@ Sat Nov 21  18:00 1998 Gerard Roudier (g
 	- Still a buglet in the tags initial settings that needed to be fixed.
 	  It was not possible to disable TGQ at system startup for devices 
 	  that claim TGQ support. The driver used at least 2 for the queue 
-	  depth but did'nt keep track of user settings for tags depth lower 
+	  depth but didn't keep track of user settings for tags depth lower 
 	  than 2.
 
 Wed Nov 11  10:00 1998 Gerard Roudier (groudier@club-internet.fr)
@@ -270,7 +270,7 @@ Sun Oct  4 14:00 1998 Gerard Roudier (gr
 	  were due to a SCSI selection problem triggered by a clearly 
 	  documented feature that in fact seems not to work: (53C8XX chips  
 	  are claimed by the manuals to be able to execute SCSI scripts just 
-	  after abitration while the SCSI core is performing SCSI selection).
+	  after arbitration while the SCSI core is performing SCSI selection).
 	  This optimization is broken and has been removed.
 	- Some broken scsi devices are confused when a negotiation is started 
 	  on a LUN that does not correspond to a real device. According to 
@@ -347,7 +347,7 @@ Tue Jun 4 23:00 1998 Gerard Roudier (gro
 	- Code cleanup and simplification:
 	  Remove kernel 1.2.X and 1.3.X support.
 	  Remove the _old_ target capabilities table.
-	  Remove the error recovery code that have'nt been really useful.
+	  Remove the error recovery code that hasn't been really useful.
 	  Use a single alignment boundary (CACHE_LINE_SIZE) for data 
 	  structures.
 	- Several aggressive SCRIPTS optimizations and changes:
@@ -367,8 +367,8 @@ Wed May 13 20:00 1998 Gerard Roudier (gr
 	- Some simplification for 64 bit arch done ccb address testing.
 	- Add a check of the MSG_OUT phase after Selection with ATN.
 	- The new tagged queue stuff seems ok, so some informationnal 
-	  message have been conditionned by verbose >= 3.
-	- Donnot reset if a SBMC interrupt reports the same bus mode.
+	  message have been conditioned by verbose >= 3.
+	- Do not reset if a SBMC interrupt reports the same bus mode.
 	- Print out the whole driver set-up. Some options were missing and 
 	  the print statement was misplaced for modules.
 	- Ignore a SCSI parity interrupt if the chip is not connected to 
@@ -392,7 +392,7 @@ Sat Apr 25 21:00 1998 Gerard Roudier (gr
 	  context on phase mismatch.
 	- The above allows now to use the on-chip RAM without requiring 
 	  to get access to the on-chip RAM from the C code. This makes 
-	  on-chip RAM useable for linux-1.2.13 and for Linux-Alpha for 
+	  on-chip RAM usable for linux-1.2.13 and for Linux-Alpha for 
 	  instance.
 	- Some simplifications and cleanups in the SCRIPTS and C code.
 	- Buglet fixed in parity error recovery SCRIPTS (never tested).
@@ -433,7 +433,7 @@ Sun Mar 29 12:00 1998 Gerard Roudier (gr
 
 Tue Mar 26 23:00 1998 Gerard Roudier (groudier@club-internet.fr)
 	* revision 2.6g
-	- New done queue. 8 entries by default (6 always useable).
+	- New done queue. 8 entries by default (6 always usable).
 	  Can be increased if needed.
 	- Resources management using doubly linked queues.
 	- New auto-sense and QUEUE FULL handling that does not need to 
@@ -464,7 +464,7 @@ Sun Jan 11 22:00 1998 Gerard Roudier (gr
 	- generalization of the restart of CCB on special condition as 
           Abort, QUEUE FULL, CHECK CONDITION.
           This has been called 'silly scheduler'.
-	- make all the profiling code conditionned by a config option.
+	- make all the profiling code conditioned by a config option.
 	  This spare some PCI traffic and C code when this feature is not 
           needed.
 	- handle more cleanly the situation where direction is unknown.
diff -- a/Documentation/scsi/ChangeLog.sym53c8xx b/Documentation/scsi/ChangeLog.sym53c8xx
--- a/Documentation/scsi/ChangeLog.sym53c8xx
+++ b/Documentation/scsi/ChangeLog.sym53c8xx
@@ -255,7 +255,7 @@ Sat Sep 11  11:00 1999 Gerard Roudier (g
 	- Work-around PCI chips being reported twice on some platforms.
 	- Add some redundant PCI reads in order to deal with common 
 	  bridge misbehaviour regarding posted write flushing.
-	- Add some other conditionnal code for people who have to deal 
+	- Add some other conditional code for people who have to deal 
 	  with really broken bridges (they will have to edit a source 
 	  file to try these options).
 	- Handle correctly (hopefully) jiffies wrap-around.
@@ -300,7 +300,7 @@ Sat May 29  12:00 1999 Gerard Roudier (g
 Tue May 25  23:00 1999 Gerard Roudier (groudier@club-internet.fr)
 	* version sym53c8xx-1.5a
 	- Add support for task abort and bus device reset SCSI message 
-	  and implement proper synchonisation with SCRIPTS to handle 
+	  and implement proper synchronisation with SCRIPTS to handle 
           correctly task abortion without races.
 	- Send an ABORT message (if untagged) or ABORT TAG message (if tagged)
 	  when the driver is told to abort a command that is disconnected and 
@@ -410,7 +410,7 @@ Fri Feb 12  23:00 1999 Gerard Roudier (g
 	  the support of non compliant SCSI removal, insertion and all 
 	  kinds of screw-up that may happen on the SCSI BUS.
 	  Hopefully, the driver is now unbreakable or may-be, it is just 
-	  quite brocken. :-)
+	  quite broken. :-)
 	  Many thanks to Johnson Russel (Symbios) for having responded to 
 	  my questions and for his interesting advices and comments about 
 	  support of SCSI hot-plug.
@@ -432,7 +432,7 @@ Sun Jan 31  18:00 1999 Gerard Roudier (g
 Sun Jan 24  18:00 1999 Gerard Roudier (groudier@club-internet.fr)
 	* version sym53c8xx-1.1
 	- Major rewrite of the SCSI parity error handling.
-	  The informations contained in the data manuals are incomplete about 
+	  The information contained in the data manuals is incomplete about 
 	  this feature.
 	  I asked SYMBIOS about and got in reply the explanations that are 
 	  _indeed_ missing in the data manuals.
@@ -460,7 +460,7 @@ Sat Dec 19  21:00 1998 Gerard Roudier (g
 	- Revamp slightly the Symbios NVRAM lay-out based on the excerpt of 
 	  the header file I received from Symbios.
 	- Check the PCI bus number for the boot order (Using a fast 
-	  PCI controller behing a PCI-PCI bridge seems sub-optimal).
+	  PCI controller behind a PCI-PCI bridge seems sub-optimal).
 	- Disable overlapped PCI arbitration for the 896 revision 1.
 	- Reduce a bit the number of IO register reads for phase mismatch 
 	  by reading DWORDS at a time instead of BYTES.
@@ -488,7 +488,7 @@ Sun Nov 29  18:00 1998 Gerard Roudier (g
 Tue Nov 24  23:00 1998 Gerard Roudier (groudier@club-internet.fr)
 	* version pre-sym53c8xx-0.16
 	- Add SCSI_NCR_OPTIMIZE_896_1 compile option and 'optim' boot option.
-	  When set, the driver unconditionnaly assumes that the interrupt 
+	  When set, the driver unconditionally assumes that the interrupt 
 	  handler is called for command completion, then clears INTF, scans 
 	  the done queue and returns if some completed CCB is found. If no 
 	  completed CCB are found, interrupt handling will proceed normally.
@@ -502,7 +502,7 @@ Tue Nov 24  23:00 1998 Gerard Roudier (g
 	- Still a buglet in the tags initial settings that needed to be fixed.
 	  It was not possible to disable TGQ at system startup for devices 
 	  that claim TGQ support. The driver used at least 2 for the queue 
-	  depth but did'nt keep track of user settings for tags depth lower 
+	  depth but didn't keep track of user settings for tags depth lower 
 	  than 2.
 
 Thu Nov 19  23:00 1998 Gerard Roudier (groudier@club-internet.fr)
diff -- a/Documentation/scsi/ChangeLog.sym53c8xx_2 b/Documentation/scsi/ChangeLog.sym53c8xx_2
--- a/Documentation/scsi/ChangeLog.sym53c8xx_2
+++ b/Documentation/scsi/ChangeLog.sym53c8xx_2
@@ -40,7 +40,7 @@ Wed Feb 7 21:00 2001 Gerard Roudier
 	- Call pci_enable_device() as wished by kernel maintainers.
 	- Change the sym_queue_scsiio() interface.
 	  This is intended to simplify portability.
-	- Move the code intended to deal with the dowloading of SCRIPTS 
+	- Move the code intended to deal with the downloading of SCRIPTS 
 	  from SCRIPTS :) in the patch method (was wrongly placed in 
 	  the SCRIPTS setup method).
 	- Add a missing cpu_to_scr()  (np->abort_tbl.addr)
@@ -53,9 +53,9 @@ Sat Mar 3 21:00 2001 Gerard Roudier
 	  Also move the code that sniffes INQUIRY to sym_misc.c.
 	  This allows to share the corresponding code with NetBSD 
 	  without polluating the core driver source (sym_hipd.c).
-	- Add optionnal code that handles IO timeouts from the driver.
+	- Add optional code that handles IO timeouts from the driver.
 	  (not used under Linux, but required for NetBSD)
-	- Donnot assume any longer that PAGE_SHIFT and PAGE_SIZE are 
+	- Do not assume any longer that PAGE_SHIFT and PAGE_SIZE are 
 	  defined at compile time, as at least NetBSD uses variables 
 	  in memory for that.
 	- Refine a work-around for the C1010-33 that consists in 
@@ -104,7 +104,7 @@ Sun Sep 9 18:00 2001 Gerard Roudier
 	- Change my email address.
 	- Add infrastructure for the forthcoming 64 bit DMA addressing support.
 	  (Based on PCI 64 bit patch from David S. Miller)
-	- Donnot use anymore vm_offset_t type.
+	- Do not use anymore vm_offset_t type.
 
 Sat Sep 15 20:00 2001 Gerard Roudier 
 	* version sym-2.1.13-20010916
@@ -119,7 +119,7 @@ Sat Sep 22 12:00 2001 Gerard Roudier
 
 Sun Sep 30 17:00 2001 Gerard Roudier 
 	* version sym-2.1.15-20010930
-	- Include <linux/module.h> unconditionnaly as expected by latest
+	- Include <linux/module.h> unconditionally as expected by latest
 	  kernels.
 	- Use del_timer_sync() for recent kernels to kill the driver timer 
 	  on module release.
