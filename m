Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A488671471
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjARGlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjARG14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:27:56 -0500
Received: from fallback16.mail.ru (fallback16.mail.ru [94.100.177.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5522439CEC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=oW8Gkmc0NU6caq9sWFpR23hC2NF8lfm6O9Jx1zqcY18=;
        t=1674022725;x=1674112725; 
        b=gUVDBSHXYQcgbSb8KcHsdU0U5uYg/bbnR/YTHzXMCa5FrAl7wP5DMvsnqA0q/GpBzSkMpwPMUdyEJNZHpRtbdsTn4Z+gn5PnYf9AF4wgHZv3mBC1n/ICRJk4BAyPtnjFmfM8sIF4Z5Ssj+UDItykz57kmcITkgf4JLTIesmPfQDf45LQTLNtwgqH7mYR/khe+SmeX/4Niwj9muLA7u6LwWoGAq/99CiGpYQ2TJl47ApP4znvdAHHU7TWzIjQXsVrPZqTJitQ2wiCrTvoxntxC3OJw6m7UrWKrorvFRYlWD5Hylc7e1MxaI+Th+MQSmCuK3acE0fYwavDqaxio/niAA==;
Received: from [10.161.100.15] (port=58052 helo=smtpng3.i.mail.ru)
        by fallback16.i with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1pI1mV-0006Fx-DO
        for linux-kernel@vger.kernel.org; Wed, 18 Jan 2023 09:18:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=oW8Gkmc0NU6caq9sWFpR23hC2NF8lfm6O9Jx1zqcY18=;
        t=1674022723;x=1674112723; 
        b=tJKMJwYc67WG4Q+7UAleC3+XvaJek9Nq2a3jOfGgxhStLDGyaVmwK5ZdWRTfJJdJgDVfvfJ/tSxlv3cz6i3AxNx41PMUIxY8fg+5ippyX4A5ERLt+7GVWdY7mlV5BGbUEDnKuAezaSbLOHrYN76tgA36ZT2oG16e7Fx53GZFOs13N9Zh6d67Z8jB3if+qKy3n+IxkUmEAF2zwvKR49VnXWZmiWsk0dMV0WD50O/xolubwbqBpfIMAVpBPJfbF61OSDc7hkFRTPQVNuvmN3jHBQCQaKnQwxjNZ4bdi5rU/Hk+feQDf8VwCKzwhVVi3uvUDyPpwJxB/ujTd2aGz1BCvw==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1pI1mP-0000T3-Ak; Wed, 18 Jan 2023 09:18:38 +0300
Message-ID: <ad986189-4ecb-5c03-a0a7-b5d91d4ae37f@inbox.ru>
Date:   Wed, 18 Jan 2023 09:18:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 RESEND] drivers: bus: simple-pm-bus: Use clocks
To:     Liu Ying <victor.liu@nxp.com>, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, geert+renesas@glider.be,
        saravanak@google.com, linux-imx@nxp.com, greg@kroah.com,
        arnd@arndb.de
References: <20221226031417.1056745-1-victor.liu@nxp.com>
Content-Language: en-US
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20221226031417.1056745-1-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD90D1502B3BE350FE4F8E4D4842A17DDFCDDA8BA9CCAEF35FF00894C459B0CD1B98F80053A26687A79D399E7C09BCE190CC2348F2EAB1805B8ACCB5262BB581CA2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE711269A7C2F827F16EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371D5B197C6EC5B4BE8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D86AE81A3AB1D0F234FF624B331279E5E06F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE709B92020B71E24959FA2833FD35BB23D9E625A9149C048EE1E561CDFBCA1751FCB629EEF1311BF91D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B8504066E4625DE84A471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CAA44A86D94E7BBB043847C11F186F3C59DAA53EE0834AAEE
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3482189E76C6218D8F84BF8B30F0EA05D96B1E92CC3D480F4767B23F380EDFB74CDA045C3D8713BCDB1D7E09C32AA3244C1AA94B6C95E2B0C236833020475B56A7259227199D06760AAD832FF50B3043B1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojrgi5U++pMSPZQytazu08Hw==
X-Mailru-Sender: 689FA8AB762F73933AF1F914F131DBF55D81B393AACEC83002C4CB668CC6FA9D98CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B41CF11DA7185A12D6AD7DD622C933E1B869753D7DFCFB718468F3CF0E9FE49B699F9FBDB65A60DACAECD261E14A1637077E92CC731C62C7306B9F2C60DD9ACCB6
X-7FA49CB5: 0D63561A33F958A5B30494A24A0C44CE5C2F854C719B8AEAF0382FE75BD04DCFCACD7DF95DA8FC8BD5E8D9A59859A8B68E6A4215806F4BA1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdXAer6iYXgmwx2pc1/t9bRw==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.12.2022 06:14, Liu Ying wrote:
> Simple Power-Managed bus controller may need functional clock(s)
> to be enabled before child devices connected to the bus can be
> accessed.  Get the clock(s) as a bulk and enable/disable the
> clock(s) when the bus is being power managed.
> 
> One example is that Freescale i.MX8qxp pixel link MSI bus controller
> needs MSI clock and AHB clock to be enabled before accessing child
> devices.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
Tested-by: Maxim Kochetkov <fido_max@inbox.ru>
