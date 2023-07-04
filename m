Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2228B74787E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjGDSzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGDSzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:55:42 -0400
X-Greylist: delayed 377 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 11:55:38 PDT
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E66A10DA;
        Tue,  4 Jul 2023 11:55:38 -0700 (PDT)
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
        by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4QwWzT5bNlz7yX1;
        Tue,  4 Jul 2023 20:49:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zint.sh; s=key2;
        t=1688496549; bh=GVVynhEK68eJoN+Xsj0RlcQA++1FHUnmaP+Aw5+SQ4g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jnQK69vAou/xQVuMz2ytODPp6xM6LCRSOPZmzl7sgG9ENUQpfV5OeHRzmcZRVdnwy
         6oWG353pRSgjMdEaIB89OAVhSiWICDi3vBj+wUKZkulZysBT4bJW8okmXcBgb8gz8e
         36CJ8Hzk/xhEM6uOrpEYJXjFVmk5HiBzBxIsm2J5c/eMjYlzg3Rfhp/FDY0CWUH9Jq
         ihVr9Jzo8PQaKwqee8bH24XWtg450C639Pa0emZWfSKN0EGRp4/loceUU6+Mi7ak8E
         5jQfEjHhBolL97Qdb5F3tJ16PaXOGApNRvLs+Q+QprMTGgWFQza+StDXddxNwWO1zI
         jYyAo+cxzj/gg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4QwWzT5Cmwz7yVH;
        Tue,  4 Jul 2023 20:49:09 +0200 (CEST)
Received: from mxe217.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy02-mors.netcup.net (Postfix) with ESMTPS id 4QwWzT0Sb5z8sWf;
        Tue,  4 Jul 2023 20:49:09 +0200 (CEST)
Received: from [192.168.178.29] (p5dcce794.dip0.t-ipconnect.de [93.204.231.148])
        by mxe217.netcup.net (Postfix) with ESMTPSA id 41606816E7;
        Tue,  4 Jul 2023 20:49:00 +0200 (CEST)
Message-ID: <fae34bb8-9e4b-41db-bf53-6d9e587ab00e@zint.sh>
Date:   Tue, 4 Jul 2023 20:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/1] Backlight driver for the Apple Studio Display
Content-Language: en-US
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>
References: <20230701120806.11812-1-julius@zint.sh>
From:   Julius Zint <julius@zint.sh>
In-Reply-To: <20230701120806.11812-1-julius@zint.sh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 41606816E7
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: Vm9HcxEdPwFhbv4UrnaEJHdgHLLTduxm4XYC06rc
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I appreciate all of the feedback, this should be plenty for a v2.

Thanks,

Julius
