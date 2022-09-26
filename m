Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498105EB2E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiIZVMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiIZVMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:12:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A3816A1;
        Mon, 26 Sep 2022 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664226731; x=1695762731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wM8U/+Gl73sPho1s2SA6QSooOy4H6zdBbgwSMTYT7nU=;
  b=aZzeLvS1JrSMqRorp/jtM7T7lP7ejS1dPhE+2mJ2P1U+LLX68inV1+M0
   Ksz8aMSccEohIo7Qj26WHJxqxG99gGsaAaYTvMKQKJudVnHt0EtpJYUkS
   ZhMq9QEgFPiYbCn29MEmE+rKjg0BlP0nGLSedTJQDsrwfDxXag/UYR408
   +0kNNA7W1oefB+Uhb5FUCK0opaARjKLAlt5DaQUclKE4oUL76LkRSVimJ
   dohLKeJEMKw0fxCYGG7uriJbaxxl7Oa3Ff0mvhAg4RXXluJT+/OZ1mx4J
   lqDJIPsmQHRaPAmqwjARQrXtmkj+ip2XWdKtYKEBn2oNnJT92p4WbpeO3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="327497258"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="327497258"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 14:12:10 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="654435268"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="654435268"
Received: from andrewjy-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.166.96])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 14:12:10 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-doc@vger.kernel.org, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/CoC: Reflect current CoC interpretation and practices
Date:   Mon, 26 Sep 2022 14:11:49 -0700
Message-Id: <20220926211149.2278214-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Code of Conduct interpretation does not reflect the current
practices of the CoC committee or the TAB. Update the documentation
to remove references to initial committees and boot strap periods
since it is past that time, and note that the this document
does serve as the documentation for the CoC committee processes.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../code-of-conduct-interpretation.rst        | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
index 4f8a06b00f60..922e0b547bc3 100644
--- a/Documentation/process/code-of-conduct-interpretation.rst
+++ b/Documentation/process/code-of-conduct-interpretation.rst
@@ -127,10 +127,12 @@ are listed at https://kernel.org/code-of-conduct.html.  Members can not
 access reports made before they joined or after they have left the
 committee.
 
-The initial Code of Conduct Committee consists of volunteer members of
-the TAB, as well as a professional mediator acting as a neutral third
-party.  The first task of the committee is to establish documented
-processes, which will be made public.
+The Code of Conduct Committee consists of volunteer community members
+appointed by the TAB, as well as a professional mediator acting as a
+neutral third party.  The processes the Code of Conduct committee will
+use to address reports is varied and will depend on the individual
+circumstance, however, this file serves as documentation for the
+general process used.
 
 Any member of the committee, including the mediator, can be contacted
 directly if a reporter does not wish to include the full committee in a
@@ -141,16 +143,16 @@ processes (see above) and consults with the TAB as needed and
 appropriate, for instance to request and receive information about the
 kernel community.
 
-Any decisions by the committee will be brought to the TAB, for
-implementation of enforcement with the relevant maintainers if needed.
-A decision by the Code of Conduct Committee can be overturned by the TAB
-by a two-thirds vote.
+Any decisions regarding enforcement recommendations will be brought to
+the TAB for implementation of enforcement with the relevant maintainers
+if needed.  A decision by the Code of Conduct Committee can be overturned
+by the TAB by a two-thirds vote.
 
 At quarterly intervals, the Code of Conduct Committee and TAB will
 provide a report summarizing the anonymised reports that the Code of
 Conduct committee has received and their status, as well details of any
 overridden decisions including complete and identifiable voting details.
 
-We expect to establish a different process for Code of Conduct Committee
-staffing beyond the bootstrap period.  This document will be updated
-with that information when this occurs.
+Because how we interpret and enforce the Code of Conduct will evolve over
+time, this document will be updated when necessary to reflect any
+changes.
-- 
2.37.3

