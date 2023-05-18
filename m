Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CB8708A83
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjERV2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjERV2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:28:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B43E10C6;
        Thu, 18 May 2023 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Dykfym+h/fBFI+QSChaFq+A6w9GQjFVudoBE08aqTKQ=; b=l6TwZDVz5xktrEEcffBG7ylf7C
        bpzTOidYU8TPWGiDPdEDxlJmnzO04hUghnYE4dhVo+tg6EdhPMpCdifUYnPo7hfqKLjq86eqPFwAv
        fsu4bDkEne8YpnQ1xG1s1q7swTXfB5B062/LWgGTzqYAgOtMjvfy6z75pR9SXHBiTuM9LIGiLKTSh
        aXEScrSx+YI1EKFUAEM0BYB9Nan0JSF0nakGzNK+txQWnv9hZDrzTrONVy5tS6erH4taPU0fnqYjQ
        6emQMv7pVrBx1F1GcVa24aBXsa5cTw5ZnsugmuC/tjFZqYAfDDltDhpj2iG2j3RXHD5vDqg/XhVbQ
        zaYQJChw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzlA9-00EFRV-0z;
        Thu, 18 May 2023 21:27:53 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Gerd Knorr <kraxel@bytesex.org>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>, dc395x@twibble.org,
        James Smart <james.smart@broadcom.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        megaraidlinux.pdl@broadcom.com,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 00/11] Documentation/scsi: organize SCSI docs & make more readable
Date:   Thu, 18 May 2023 14:27:38 -0700
Message-Id: <20230518212749.18266-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Organize the SCSI documentation into categories instead of
alphabetically by filename.

Modify several of the document chapter headings so that they are
shorter and easier to find.

Make several updates to the scsi-generic driver documentation.

 [PATCH 01/11] Docs/scsi: organize the SCSI documentation
 [PATCH 02/11] Docs/scsi: introduction: multiple cleanups
 [PATCH 03/11] Docs/scsi: arcmsr: use a chapter heading for clarity
 [PATCH 04/11] Docs/scsi: scsi-changer: shorten the chapter heading
 [PATCH 05/11] Docs/scsi: dc395x: shorten the chapter heading
 [PATCH 06/11] Docs/scsi: scsi_fc_transport: fix typo in heading
 [PATCH 07/11] Docs/scsi: scsi-generic: multiple cleanups
 [PATCH 08/11] Docs/scsi: g_NCR5380: shorten chapter heading
 [PATCH 09/11] Docs/scsi: megaraid: clarify chapter heading
 [PATCH 10/11] Docs/scsi: ncr53c8xx: shorten chapter heading
 [PATCH 11/11] Docs/scsi: sym53c8xx_2: shorten chapter heading


 Documentation/scsi/arcmsr_spec.rst       |    1 
 Documentation/scsi/dc395x.rst            |    6 +-
 Documentation/scsi/g_NCR5380.rst         |    6 +-
 Documentation/scsi/index.rst             |   37 ++++++++++++--
 Documentation/scsi/megaraid.rst          |    6 +-
 Documentation/scsi/ncr53c8xx.rst         |    6 +-
 Documentation/scsi/scsi-changer.rst      |    6 +-
 Documentation/scsi/scsi-generic.rst      |   53 ++++++++-------------
 Documentation/scsi/scsi.rst              |   23 +++------
 Documentation/scsi/scsi_fc_transport.rst |    8 +--
 Documentation/scsi/sym53c8xx_2.rst       |    6 +-
 11 files changed, 86 insertions(+), 72 deletions(-)


Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Gerd Knorr <kraxel@bytesex.org>
Cc: Oliver Neukum <oliver@neukum.org>
Cc: Ali Akcaagac <aliakc@web.de>
Cc: Jamie Lenehan <lenehan@twibble.org>
Cc: dc395x@twibble.org
Cc: James Smart <james.smart@broadcom.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: megaraidlinux.pdl@broadcom.com
Cc: Matthew Wilcox <willy@infradead.org>
