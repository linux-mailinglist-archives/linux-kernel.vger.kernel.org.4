Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708AA5B5482
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiILG2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiILG1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:27:44 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B471573B;
        Sun, 11 Sep 2022 23:27:02 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id j10so2657341qtv.4;
        Sun, 11 Sep 2022 23:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=DDSVSFUDLu7+OVWbeRCI3LlbDJDT8qUS0omm4f+6IBo=;
        b=iN+gG7tdDhB3UwAhcuzbb7FhAKkhCTRLv1wecbolTo67uZr5qc99VCuCo8bpbf5BGE
         8BtxsDUjlsW/QTRaO5rdZyxMsBGCUNo25opKnfjd+lEm3BoI82JCDMcVslX4SDgv7fpV
         kGjuy2i6+XOydcj2cflH3OVPS1acyuzBVYg/2/m4mbB37Nk6CZtmMEheITICTjnWBir9
         04Gy7CXY55x/0s0z3NoWnhA6l1AmFxaTV8J53S+cUxWjncb3/YNG66sygW0bWbVGoRrY
         RJUCswzfIw+KdtwB5Cmkrtbk+GxdoK4YhJFZ32bPJTlP428d71CnokCX/M9NwPzHV1O6
         4z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=DDSVSFUDLu7+OVWbeRCI3LlbDJDT8qUS0omm4f+6IBo=;
        b=Q/f4ewYLqjpJOh9vwWhpkLiW7fLJDyOsbNHoepuqlYQUOSOd8cy2FbSVF0iUaNvC0J
         TxbsxBkEsGYKdD7bgGMzrDJwD6YtKvcVjN419WoH+tMQVrJjl/VGCiCUMJvnVULK7i/t
         KyT3Z/8iSbXt/M5Yo5/z8Opx2NxhvyywO45c0TvJXV3vHrHefdu2GGR+3T1LxCyRPaxR
         p53R/nX8+3UFOIesakKz9e5nZL/qrODU7YZYisblZBW3rIyFB2yYsitLyFx2GLc5tOF+
         9K1t1p2avf6SCP7i1XVUb+9vq1PpHxe8VwLhtPbudmx3VfJ1YRywVJwhka5gaXe3+bek
         gQzg==
X-Gm-Message-State: ACgBeo1eVGquDZIIXBykwR6CDO+B0KUSHpsfynmW3l61e9So2VbvmwuE
        QfRWkASeBh9ayltbzKvTwDM=
X-Google-Smtp-Source: AA6agR6fqKt4BFMeedcGDEfdW4+5f9TC+/YCYtnKJoy0f2tXw/36/VAz4n4EPggv4EibkVoc6Jd66Q==
X-Received: by 2002:a05:622a:19a3:b0:35b:ad2f:6f46 with SMTP id u35-20020a05622a19a300b0035bad2f6f46mr6555805qtc.7.1662964021169;
        Sun, 11 Sep 2022 23:27:01 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:a464:4449:dc4c:dd3d])
        by smtp.gmail.com with ESMTPSA id k22-20020ac84756000000b0035a6f14b3cesm5845109qtp.27.2022.09.11.23.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:27:00 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] of: expand overlay documentation
Date:   Mon, 12 Sep 2022 01:26:15 -0500
Message-Id: <20220912062615.3727029-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The overlay documentation is incomplete, start adding more content.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

I have not done a build and have not verified the formatting.

This is a first stab to try to capture some of the content that I
think should be added to the overlay documentation.  I wanted to
give it some exposure instead of letting it languish outside of
public view.

 Documentation/devicetree/overlay-notes.rst | 142 +++++++++++++++++++--
 1 file changed, 128 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
index e139f22b363e..ac98923bf256 100644
--- a/Documentation/devicetree/overlay-notes.rst
+++ b/Documentation/devicetree/overlay-notes.rst
@@ -4,18 +4,117 @@
 Devicetree Overlay Notes
 ========================
 
-This document describes the implementation of the in-kernel
+This document provides information about device tree overlays.  This includes
+both (1) applying the overlay to the base device tree blob before providing the
+device tree blob to the kernel and (2) applying overlays to the base device
+tree after the kernel has booted.
+
+Impact on both pre-boot and post-boot apply
+-------------------------------------------
+
+The base devicetree is typically compiled by scripts/dtc with the "--symbols"
+or "-@' option if an overlay will be applied to the base devicetree.  This
+results in a larger device tree blob that contains symbolic information that
+can be used when applying an overlay blob.  The size of the symbolic
+information can be modest or very large, depending on the content of the
+base device tree source.
+
+The device tree compiler processing of duplicate or conflicting source items
+is very different than C compilers.  When an item occurs in more than one
+location of the source then the final one encountered replaces any previous
+occurences.  This provides a flexible ability to combine multiple include
+files in various configurations to create device tree blobs that describe
+similar but differing systems.  The downside of this flexibility is that it
+can be difficult to determine exactly which location in which source file
+results in an item in the compiled device tree blob.  The "--annotate", "-T",
+and "-T -T" were added to the scripts/dtc compiler to provide information
+about which particular source location describes each item in the compiled
+output.  These options are only useful when combined with "-O dts" or
+"--out-format dts".  There is no analogous option for scripts/fdtoverlay,
+so the location of the source definition of any specific item after applying
+an overlay to a base device tree blob is not available.
+
+A method of generating the --annotate information for one or more overlays
+applied to a base device tree that might work is:
+::
+   ---- base.dts
+   #include base.dtsi
+
+   ---- base.dtsi
+   /* the actual source of the base dts */
+
+   ---- overlay.dts
+   /plugin/
+   #include overlay.dtsi
+
+   ---- overlay.dtsi
+   /* the actual source of the overlay dts */
+
+   ---- base_and_overlay.dts
+   #include base.dtsi
+   #include overlay.dtsi
+
+   To generate the annotated device tree, use the command:
+      scripts/dtc --annotate -O dts base_and_overlay.dts
+
+The downside of this method is that a unique base_and_overlay.dts is required
+for each combination of a base device tree and the various combinations of
+overlays that may be applied to the base device tree.  This could result
+in a large number of base_and_overlay.dts files in the kernel source tree.
+It is likely that each person who desires to debug the contents of overlays
+applied to a base device tree would create the appropriate base_and_overlay.dts
+file in the own development environment instead of maintaining them in the
+kernel source tree.
+
+There is no guarantee that this method would generate a device tree
+equivalent to a device tree created by scripts/fdtoverlay or a device tree
+created post boot by applying an overlay because the overlay apply process
+may implement different rules or restrictions than scripts/dtc does.
+
+Pre-boot overlay apply
+-------------------------------------------
+
+One or more overlays may be applied to a base device tree by
+scripts/fdtoverlay.  The resulting output DT blob can be provided to the
+kernel for booting.
+
+This method is supported and is strongly encouraged.
+
+
+Post-boot overlay apply
+-------------------------------------------
+
+Run time overlay apply and run time overlay remove from user space are
+not supported in the mainline kernel. There are out of tree patches to
+implement this feature via an overlay manager. The overlay manager is used
+successfully by many users for specific overlays on specific boards with
+specific environments and use cases. However, there are many issues with
+the Linux kernel overlay implementation due to incomplete and incorrect
+code. The overlay manager has not been accepted in mainline due to these
+issues. Once these issues are resolved, it is expected that some method
+of run time overlay apply and overlay removal from user space will be
+supported by the Linux kernel.
+
+For a more detailed description of kernel issues and the progress of
+resolving the issues, see
+::
+   https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts
+
+This method is only partially implemented, is fragile, and is strongly
+discouraged.  The resulting system may or may not function as expected
+and is not supported.  Fixes to issues resulting from this method may
+or may not be accepted in the device tree kernel source code (eg in
+drivers/of/).
+
+This section describes the implementation of the in-kernel
 device tree overlay functionality residing in drivers/of/overlay.c and is a
 companion document to Documentation/devicetree/dynamic-resolution-notes.rst[1]
 
-How overlays work
------------------
-
 A Devicetree's overlay purpose is to modify the kernel's live tree, and
 have the modification affecting the state of the kernel in a way that
 is reflecting the changes.
 Since the kernel mainly deals with devices, any new device node that result
-in an active device should have it created while if the device node is either
+in an active device should have it created.  If the device node is either
 disabled or removed all together, the affected device should be deregistered.
 
 Lets take an example where we have a foo board with the following base tree::
@@ -104,22 +203,20 @@ The above bar.dts example modified to use target path syntax is::
 
 
 Overlay in-kernel API
---------------------------------
-
-The API is quite easy to use.
+-------------------------------------------
 
 1) Call of_overlay_fdt_apply() to create and apply an overlay changeset. The
    return value is an error or a cookie identifying this overlay.
 
 2) Call of_overlay_remove() to remove and cleanup the overlay changeset
-   previously created via the call to of_overlay_fdt_apply(). Removal of an
-   overlay changeset that is stacked by another will not be permitted.
+   previously created via the call to of_overlay_fdt_apply(). Removal of
+   overlay changesets must occur in the opposite order of apply (the
+   most recently applied overlay changeset must be removed first).
 
-Finally, if you need to remove all overlays in one-go, just call
-of_overlay_remove_all() which will remove every single one in the correct
-order.
+If you need to remove all overlays in one-go, just call of_overlay_remove_all()
+which will remove every single overlay changeset in the correct order.
 
-There is the option to register notifiers that get called on
+There is an option to register notifiers that get called on
 overlay operations. See of_overlay_notifier_register/unregister and
 enum of_overlay_notify_action for details.
 
@@ -142,9 +239,26 @@ Any other code that retains a pointer to the overlay nodes or data is
 considered to be a bug because after removing the overlay the pointer
 will refer to freed memory.
 
+All overlay related notifiers are subject to especially cautious review.
+
 Users of overlays must be especially aware of the overall operations that
 occur on the system to ensure that other kernel code does not retain any
 pointers to the overlay nodes or data.  Any example of an inadvertent use
 of such pointers is if a driver or subsystem module is loaded after an
 overlay has been applied, and the driver or subsystem scans the entire
 devicetree or a large portion of it, including the overlay nodes.
+
+Post-boot overlay apply constraints
+-------------------------------------------
+
+The post-boot overlay apply code constrains what a valid overlay may contain.
+
+This is a very incomplete list of such constraints.
+
+::
+   - An overlay may not replace an existing node or property.  A special
+     exception is that the value of the "status" property can be changed
+     to "ok".  Whether this change will be properly detected and processed
+     depends upon the relevant subsystem(s) and driver(s).
+
+   - An overlay may not add a property to an existing node.
-- 
Frank Rowand <frank.rowand@sony.com>

