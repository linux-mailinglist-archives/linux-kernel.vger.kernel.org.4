Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A2571179A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjEYTrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbjEYTrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:47:13 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E527EE69;
        Thu, 25 May 2023 12:46:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9608D5C0351;
        Thu, 25 May 2023 15:46:19 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Thu, 25 May 2023 15:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1685043979; x=1685130379; bh=ds
        54NBbEQEF4Jg2h5usa6N/fyRH0XIYDquJWQjOiKKk=; b=XcHvR1B/PkzInUdwBm
        dljh0a5+oSLSPG5QLy0CoXC+xpKcmkOdhnJRJFb9tRoIS9QfbmvCF9sODaO5ov+5
        9fWrxTJO3fCRIZsI0q36CDPVlM5P6zhGg4Js940Yma6Nti76yRM8x4mRl0R0j4Qs
        Nf66uGtpWafQ1plMLECbAgqrJvAdPt7QEserk6pUgsZ7lqRUhZDveuQxTFNYgW74
        9WMimYWZwd9xsVDjzJyaGs5Bl5irnYWbabsaUdJ+B7lCusTotrLKMLEdRE58F+Zi
        O/TD2STJl7L56t/WAXYSoH12B4J6te2IX3I5uk2yHnHpOVVFcth2a6LCdJGBSR5g
        GiBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685043979; x=1685130379; bh=ds54NBbEQEF4J
        g2h5usa6N/fyRH0XIYDquJWQjOiKKk=; b=m149zc9UscX8OVCH2GDQQUhVmqw/R
        IUMOd685IH0okcp+LxPIIUpttDE25pRm66/ziE3Kf4rYAHsAeZ8rmj6TlMNlz9rW
        4vTtmcM41YoLwFG1Ud6s47BlHdKP+kYReAKQxmWs4Wy1sbve1loba2leIpg1Mb1W
        Gtz8PncixGNgdICgKCGsUD5WT0RXydjLz5CJCZA6rrDMq8WG+12CoS2gNWeUlir7
        luxHe9cU0jO/ihcve526mAckMuPcEGKl8ckTIqqg3rp6uMCVQTeji+Qhd9Qtt6O1
        KbWPTTVSB757U7bTAizcy2XMPxJOJAzTsR75G186j6XLJps+HTKbI+JvQ==
X-ME-Sender: <xms:C7tvZAqFtnfE7FvHAK8BTrzVsQEGQqJ7oS88yGWxHG-6D_LkElK5MA>
    <xme:C7tvZGq9a41wrB0xQ9lG8IN3tMvxWBMJQMuAncjRlPBWAV3oWTEDqMbCib-e2bj5H
    Qda40hIWcsVQFFwIq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepieeufeejieevteduvdekteefledtveffvedu
    hefffeejudefvdeijeegudegkefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:C7tvZFM6JYSVwqjZmWRWO2r-gisMFhgZvTR-oIQ2NqiE0VcaRdHIUQ>
    <xmx:C7tvZH7Tp7kwAxEo3UoH-IosTIW8RVnKZ3S8im1H2f0kSwZPMfokDQ>
    <xmx:C7tvZP4E5Ex45H8RljliGnE1ltjb5c2xv-Yickvfdu_tgUpr9cyXgA>
    <xmx:C7tvZJSQihlJ3x7_ZYPtmVJywr3ucqW5EySS_zf9OpVRVuHXYfad0A>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4E287C60091; Thu, 25 May 2023 15:46:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <dcb86bf8-f83c-459e-8170-b01a96ef5690@app.fastmail.com>
In-Reply-To: <e5c4c61c-a3a3-97d0-ad50-8c5b345dc334@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20230525193132.3727-1-mpearson-lenovo@squebb.ca>
 <20230525193132.3727-3-mpearson-lenovo@squebb.ca>
 <17963a3d-996f-4bb8-918e-aadba15be9bc@app.fastmail.com>
 <e5c4c61c-a3a3-97d0-ad50-8c5b345dc334@redhat.com>
Date:   Thu, 25 May 2023 15:45:58 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] platform/x86: think-lmi: Correct NVME password handling
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, May 25, 2023, at 3:43 PM, Hans de Goede wrote:
> Hi,
>
> On 5/25/23 21:39, Mark Pearson wrote:
>> Hi Hans,
>> 
>> My apologies - I completely forgot to add the v2 tag on this patch series...had a complete brain fart.
>
> No worries I did not even notice the v2 was missing,
> my brain automatically added it :)
> 
>> I assume I should resend them all - correctly named.
>
> Well I have some review remarks on patch 5/5, it would be good if you 
> can address those (if you agree with them) and then lets jump straight 
> to v3 to avoid confusion ?
>
Works for me :)

Mark
