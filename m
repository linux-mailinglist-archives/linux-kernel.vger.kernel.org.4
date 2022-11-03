Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D7E617DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiKCNgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiKCNgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44EE13F47
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667482514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=ZmcebCzt2FOeDVD42tpvmfKJBiReURT8dbxDjllTuKethfP5JDnIcRcYjUEJMX7oNqV9v9
        NVX3+N9CbpSfwyPTmwjt25wrKeB/hb0E6vJTP0IxPAnZT7pgwjepQ5bVmlxsi+tarAb1RN
        /1MhvWS9saUTtyW68xN1PylWFdDKi2c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-Jyvwu7oAPNS9jpjojExOAA-1; Thu, 03 Nov 2022 09:35:09 -0400
X-MC-Unique: Jyvwu7oAPNS9jpjojExOAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D9162A5957E;
        Thu,  3 Nov 2022 13:35:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFDD82024CC0;
        Thu,  3 Nov 2022 13:35:08 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Anish Ghulati <aghulati@google.com>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH v2] KVM: x86: Use SRCU to protect zap in __kvm_set_or_clear_apicv_inhibit()
Date:   Thu,  3 Nov 2022 09:35:08 -0400
Message-Id: <20221103133508.4040134-1-pbonzini@redhat.com>
In-Reply-To: <20221102205359.1260980-1-bgardon@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo


