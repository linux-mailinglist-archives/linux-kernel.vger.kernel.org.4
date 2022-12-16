Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E025264E9A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiLPKmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiLPKlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:41:39 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE37E23E84;
        Fri, 16 Dec 2022 02:41:34 -0800 (PST)
Received: from compute6.internal (unknown [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 19C3C3201A31;
        Fri, 16 Dec 2022 05:03:32 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 16 Dec 2022 05:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671185011; x=1671271411; bh=JsPHcGrPau
        CGjm6MwBCA5u9Cw7DMSndxwxLzm9lYzrg=; b=iMBeclEblPlRi1cRWAR50B8TMw
        iUM2hJbw5QQaZ1Sfr1mr7m4wDXL+rTfPLyzpCuSXM+LKDO+L9M33bWwFHzAuVpP5
        882xRixLM2Kv9SS5BjaOqTwcVgN5NmlLHSa3JbNBe6bkGpl/fmt8Z8Iq/1xRsE9Q
        Kf6SJ3OjAVVey1scVoZmcMXK3GWpBrOy1HjqBXACFyXVVO6xATD90aMhk7Pi3BBQ
        Gq4jYZazL6l4EqxtX/LfkKEVFJmevDx4Jd0+ROvu6Ug6vMgrHZXR5LY6NsV7PwjN
        XPTppbD52SQEKewcjKUirgo+1vEcLbLFLCbc9crGZ1ewQY6gGABRrEfuF3HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671185011; x=1671271411; bh=JsPHcGrPauCGjm6MwBCA5u9Cw7DM
        SndxwxLzm9lYzrg=; b=Dn6ORmQHDJidyzCe8WvkKNGJja4ej2F9ilOL0+iWL+zs
        yl5WDzez2cKy+/KSCNBgmj3y3VScQrIV9bI64ocSTgQXlHETPiYFM9FrmTOaPinO
        n9sTvnGSjjRzG2ymoDSVKLYXom8gLV96mSr+AdRHxr3qYGBKGZQjlRHtXPvXJPV2
        DVMHLlQeXAEvgmtx+YrjEgG5uVAjtPY5crstQTWxrgHGWYfs/XASbvVPIXC9vFBf
        po5t9XlKH76ymjD8rQvLjbXRDyFX3zu46z5IYdmvfQfs01GcwDqMpX6L3OtI/2SD
        ukmqQcE1QNjo0mlgzVM/2ikaeyego755coIWuuT1iQ==
X-ME-Sender: <xms:c0KcY9Rpv0Op7S3kQzt3Ziiggo81W5Ihqk5cll6CLwfWu0xXyYhrKA>
    <xme:c0KcY2yj-oAa8orG3ZuAaLQjzF4mpxRUtJGpGQ4Tucc0jaIkans-7W1Pie9hC6uo5
    0TSVaVVa2jTXCUe4Rk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:c0KcYy31emCsP5um7VWEbNca2TuAmVoRafIOiUl2-7EhJZWy1npj8Q>
    <xmx:c0KcY1A-AN0WnI-WxPpiFyCruUZ9e48QKBxBUjlBxetwB2wK-0sycg>
    <xmx:c0KcY2gsGl80qn9Vyq05QQDzLxs79fhvK6WrwZqW44_iZ40FeEnJ1w>
    <xmx:c0KcY7aohAmLW3_TnmkEggMEx9kE4ej9uwYbJPfVJ3RFZlTHdnisIQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 72A5CB60086; Fri, 16 Dec 2022 05:03:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <02b4b94c-aa0d-4878-906d-ecd947553f16@app.fastmail.com>
In-Reply-To: <CAD=FV=U6pfSk0nY+s-p4f43Gq6-arfr8hQe8d9NC0nS0ckMYKw@mail.gmail.com>
References: <20221215165453.1864836-1-arnd@kernel.org>
 <CAD=FV=U6pfSk0nY+s-p4f43Gq6-arfr8hQe8d9NC0nS0ckMYKw@mail.gmail.com>
Date:   Fri, 16 Dec 2022 11:03:10 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Doug Anderson" <dianders@chromium.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Vijaya Krishna Nivarthi" <quic_vnivarth@quicinc.com>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        "Aniket Randive" <quic_arandive@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: qcom_geni: avoid duplicate struct member init
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022, at 21:46, Doug Anderson wrote:
> On Thu, Dec 15, 2022 at 8:55 AM Arnd Bergmann <arnd@kernel.org> wrote:

>> index b487823f0e61..03dda47184d9 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -1516,7 +1516,7 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
>>         return 0;
>>  }
>>
>> -static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
>> +static int qcom_geni_serial_sys_suspend(struct device *dev)
>
> Officially the removal of "__maybe_unused" could be a totally
> different patch, right? SET_SYSTEM_SLEEP_PM_OPS() already eventually
> used pm_sleep_ptr() even without your change, so the removal of these
> tags is unrelated to the rest of your change, right?

It's a little more complicated: SYSTEM_SLEEP_PM_OPS() uses pm_sleep_ptr()
to avoid the need for a __maybe_unused(). The depreacated
SET_SYSTEM_SLEEP_PM_OPS() is based on SYSTEM_SLEEP_PM_OPS() these days,
but still retains the old semantics of using an empty definition
without CONFIG_PM_SLEEP, so it still leaves the function unused as
far as gcc is concerned.

There could be an intermediate step of open-coding the
SET_SYSTEM_SLEEP_PM_OPS(), but that would result in the rather
silly

 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
#ifdef CONFIG_PM_SLEEP
       .suspend = qcom_geni_serial_sys_suspend,
       .resume = qcom_geni_serial_sys_resume,
       .freeze = qcom_geni_serial_sys_suspend,
       .poweroff = qcom_geni_serial_sys_suspend,
#endif
       .restore = qcom_geni_serial_sys_hib_resume,
       .thaw = qcom_geni_serial_sys_hib_resume,
}

which makes no sense to me, as I think you either want
all the members or none of them.

>>  static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
>> -       SET_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend,
>> -                                       qcom_geni_serial_sys_resume)
>> -       .restore = qcom_geni_serial_sys_hib_resume,
>> -       .thaw = qcom_geni_serial_sys_hib_resume,
>> +       .suspend = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
>> +       .resume = pm_sleep_ptr(qcom_geni_serial_sys_resume),
>> +       .freeze = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
>> +       .poweroff = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
>> +       .restore = pm_sleep_ptr(qcom_geni_serial_sys_hib_resume),
>> +       .thaw = pm_sleep_ptr(qcom_geni_serial_sys_hib_resume),
>
> Personally, the order you listed them is less intuitive than the order
> that SET_SYSTEM_SLEEP_PM_OPS() lists functions. IMO it's better to
> consistently alternate matching suspend/resume functions. ;-)

Makes sense. I kept the order that we already had here, but
I could redo this patch if anyone cares.

> Both of those are nits, so I'm also fine with:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks,

     Arnd
