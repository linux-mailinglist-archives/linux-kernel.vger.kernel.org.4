Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A06B93C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjCNMaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjCNMaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:30:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CB118AAE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678796724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=LXVnMubSgBwA7ETsMp27JU0vhIzm/eaiTtfuOqgIrvoQdYMX84mGB34IpP2Frbph6QVrji
        Cf6TVGFSqXIp/zEWtB8Zp0EQGCVqzX9h5w7cRaXQWjkGTa6HCWx08oGdpGyP+bRj88dE9F
        bLdvMGnen3KpwxRTWNf9Gsjql4Y4PXI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517--nqh_wQGMCCXB1qICSwoDA-1; Tue, 14 Mar 2023 08:01:00 -0400
X-MC-Unique: -nqh_wQGMCCXB1qICSwoDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 189E318E6C56;
        Tue, 14 Mar 2023 12:01:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A66272027040;
        Tue, 14 Mar 2023 12:00:57 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        gg@google.com, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rongtao@cestc.cn, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH v2] KVM: VMX: Fix indentation coding style issue
Date:   Tue, 14 Mar 2023 08:00:55 -0400
Message-Id: <20230314120055.3038483-1-pbonzini@redhat.com>
In-Reply-To: <tencent._5F31E6ACADCB6915E157CF5113C41803212107@qq.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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


