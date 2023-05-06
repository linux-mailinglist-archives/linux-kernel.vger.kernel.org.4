Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7806F9172
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 13:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjEFLR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 07:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjEFLRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 07:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61BE6E8F
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 04:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683371798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yca3Gg7ytayCiDGhSp4C5p2xO7St49hDWqj6wZA0jQo=;
        b=hJYEeTpqn7q2FmICnbpBsHzMjtt9Jcup60IZ7JUSyfaDg9UZ/YkqstBQYZ3x/y1c7VBk5l
        73wQM0AiV63pNVjLabZPVJGLDEXXIDY5NrjX3HOB34OiwfeH0CqQmVac4Zoki0bstoFp4Q
        HFDOMkAvbsiP2j5l95BsehNMhdfGC00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-vBMkYY6UNqqdgoYbJDLgQQ-1; Sat, 06 May 2023 07:16:34 -0400
X-MC-Unique: vBMkYY6UNqqdgoYbJDLgQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77A3C185A78B;
        Sat,  6 May 2023 11:16:34 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 657C52166B31;
        Sat,  6 May 2023 11:16:31 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND 0/2] Make PCMCIA and QCOM_HIDMA depend on HAS_IOMEM
Date:   Sat,  6 May 2023 19:16:26 +0800
Message-Id: <20230506111628.712316-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is suggested by Niklas when he reviewed patches related to s390
part:
https://lore.kernel.org/all/d78edb587ecda0aa09ba80446d0f1883e391996d.camel@linux.ibm.com/T/#u

v1 link:
https://lore.kernel.org/all/20230216073403.451455-1-bhe@redhat.com/T/#u

This resend v1 with Niklas and Arnd's ack tags added.


Baoquan He (2):
  pcmcia : make PCMCIA depend on HAS_IOMEM
  dmaengine: make QCOM_HIDMA depend on HAS_IOMEM

 drivers/dma/qcom/Kconfig | 1 +
 drivers/pcmcia/Kconfig   | 1 +
 2 files changed, 2 insertions(+)

-- 
2.34.1

