Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F896957A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjBND7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjBND7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:59:47 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C2BCDEC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676347185; x=1707883185;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=puEmpB7TX9cmSCrEtb6a06wvTDoatGPLAyrjZN6yjlQ=;
  b=Rv0Y21VfGJXqYaLye6dJiUGbXbwVJRVAHbH6JeUdbtkdQHQLzTsnM4Ah
   OfE0dl4bJ/ep0dR3UBZlEjeLthQ+7aV2E+Xl1YaHPkKMvTDEu6SUMJX1B
   udcBvpA1ouL3F2r0WVPVPhqD/vcL+ttnU0tDhJMJnV8bcG0o4iy210vSJ
   hrRQZbtwetMsKT4S3Nk1uh65iEG75qLho/LgopWgHd7Sbj+buAVNn7+eK
   r7OrLzYOZ1eUYIeKIMAPlSXYmZymrdfINekQSBXn/mGzXlXeP0eo6bd2A
   bq4AMGsSFKDapNahTnwo9+ymBnel3h5hcgnCgr3hvkDzcWEb5CltZoqrG
   w==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="221535740"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 11:59:42 +0800
IronPort-SDR: Vm9STb0CyEFC3dSHLPMm0gk7TULsAs01tCdMnab7bCCCJJMy0VfWaJHy2uBoN3bQeDGRrm54s5
 ZddD+V3WCfxLHf5xrf62L2prt/OfupC+1hpNccwc2mhOjN0fJYpx9oKSBkJePI1I/dRpc5+xfr
 4vsmPHsajySMbSOUqO5JHgIcVsUoU3rUUmrIjERpzDfvM4QWij+toPmSya2pnwmFuOFZwzU45e
 LsiLSbPgj7uBDPcPmyqxHb7At0aNGKlEIj0XNou4JYR5llMlMX6DFOL5ZejOJTaO9juTFIsD2y
 OX8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 19:16:51 -0800
IronPort-SDR: 26LjusO2D5PsfaQWK2oOqFnBHg/JZ7W67B0JTrFiJUAIJXYpx/GByGKpzMn2Dle+0k1TIv6rG/
 TXvjBuHVRBQE1sEvATUF4R04J6YRVzcJbQghcTFPwrfiYCMw3+OuRuL3ztHIOZ5SGnHPzyb8AM
 aa3reDj5DRRjSbsAYAJ2kbdKTDwD28Ehzrpmah6dQ7q+AbbjKBOu8xxvnePuloVvRx5rC7iJbS
 jfgUTr3G46SMzujCpVNz9EQLnugzkEdNTZgsVCxqsB8I3GRysk28aj6iDVT17QOieuQNrpeb/t
 i2s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 19:59:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PG6sp15jyz1RwtC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:59:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676347180; x=1678939181; bh=puEmpB7TX9cmSCrEtb6a06wvTDoatGPLAyr
        jZN6yjlQ=; b=S0+ePlRHLReSz8TjXAQ2nFh4biOunvotoPtKS1TWLiuYO0sH5T1
        UdWLIrfCLmp8z8JsTU7Vjn/K9D7SFmhXgz4Qyx3Aqm54O8Eqnj3zW6xdxVM1q6Jf
        YJUnZ4E2dKXl5bebY5Bd1ywU6woKLQsRmaoeecI4QAUdV/ybrXlLPVTJAz/JGgQb
        VHVYaueRPSovL5Rxw5eu/2xdFBdw9L08AsOaGLXsCYt3+kFAjlQPF6LoIVnE5WXv
        tf+Olt/dRXpvSlvOwb0UwCYoM8RFWbm4aVVChRBrM+OttyJqGC8NMLMEbNT9cxiv
        w19zaexGmU+v9PvPH3n90DWFH3iOQzHoodA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0zOhoFIVSpHp for <linux-kernel@vger.kernel.org>;
        Mon, 13 Feb 2023 19:59:40 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PG6sl0PxDz1RvLy;
        Mon, 13 Feb 2023 19:59:38 -0800 (PST)
Message-ID: <3d94fc3f-fbe5-a56e-3713-4f0788ebc7f9@opensource.wdc.com>
Date:   Tue, 14 Feb 2023 12:59:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] scsi: ipr: work around fortify-string warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230213101143.3821483-1-arnd@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230213101143.3821483-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 19:10, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ipr_log_vpd_compact() function triggers a fortified memcpy() warning
> about a potential string overflow with all versions of clang:
> 
> In file included from drivers/scsi/ipr.c:43:
> In file included from include/linux/string.h:254:
> include/linux/fortify-string.h:520:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                         __write_overflow_field(p_size_field, size);
>                         ^
> include/linux/fortify-string.h:520:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> 2 errors generated.
> 
> I don't see anything actually wrong with the function, but this is the
> only instance I can reproduce of the fortification going wrong in the
> kernel at the moment, so the easiest solution may be to rewrite the
> function into something that does not trigger the warning.
> 
> Instead of having a combined buffer for vendor/device/serial strings,
> use three separate local variables and just truncate the whitespace
> individually.
> 
> Fixes: 8cf093e275d0 ("[SCSI] ipr: Improved dual adapter errors")
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I did not try to bisect which commit introduced this behavior into
> the fortified memcpy(), the Fixes: commit is the one that introduced
> the ipr_log_vpd_compact() function but this predates the fortified
> string helpers.
> ---
>  drivers/scsi/ipr.c | 38 ++++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> index 198d3f20d682..490fd81e7cfd 100644
> --- a/drivers/scsi/ipr.c
> +++ b/drivers/scsi/ipr.c
> @@ -1516,23 +1516,19 @@ static void ipr_process_ccn(struct ipr_cmnd *ipr_cmd)
>  }
>  
>  /**
> - * strip_and_pad_whitespace - Strip and pad trailing whitespace.
> - * @i:		index into buffer
> - * @buf:		string to modify
> + * strip_whitespace - Strip and pad trailing whitespace.
> + * @i:		size of buffer
> + * @buf:	string to modify
>   *
> - * This function will strip all trailing whitespace, pad the end
> - * of the string with a single space, and NULL terminate the string.
> + * This function will strip all trailing whitespace and
> + * NUL terminate the string.
>   *
> - * Return value:
> - * 	new length of string
>   **/
> -static int strip_and_pad_whitespace(int i, char *buf)
> +static void strip_whitespace(int i, char *buf)
>  {
>  	while (i && buf[i] == ' ')
>  		i--;
> -	buf[i+1] = ' ';
> -	buf[i+2] = '\0';
> -	return i + 2;
> +	buf[i+1] = '\0';

If i is now the size of the buffer, this is a buffer overflow, no ? And
the initial loop should start at "i - 1" I think...

>  }
>  
>  /**
> @@ -1547,19 +1543,21 @@ static int strip_and_pad_whitespace(int i, char *buf)
>  static void ipr_log_vpd_compact(char *prefix, struct ipr_hostrcb *hostrcb,
>  				struct ipr_vpd *vpd)
>  {
> -	char buffer[IPR_VENDOR_ID_LEN + IPR_PROD_ID_LEN + IPR_SERIAL_NUM_LEN + 3];
> -	int i = 0;
> +	char vendor_id[IPR_VENDOR_ID_LEN + 1];

...but the size is in fact "i + 1"... So in strip_whitespace(), i is the
index of the last possible character in the string, and given that the
string may be much shorter, that function may not actually strip
whitespaces after the string...

> +	char product_id[IPR_PROD_ID_LEN + 1];
> +	char sn[IPR_SERIAL_NUM_LEN + 1];
>  
> -	memcpy(buffer, vpd->vpids.vendor_id, IPR_VENDOR_ID_LEN);
> -	i = strip_and_pad_whitespace(IPR_VENDOR_ID_LEN - 1, buffer);
> +	memcpy(vendor_id, vpd->vpids.vendor_id, IPR_VENDOR_ID_LEN);
> +	strip_whitespace(IPR_VENDOR_ID_LEN, vendor_id);

So this call should really be:

	strip_whitespace(strlen(vendor_id) - 1, vendor_id);

Which means that this helper can be turned into:

static void strip_whitespace(char *buf)
{
	int i = strlen(buf) - 1;

	while (i > 0 && buf[i] == ' ')
		i--;
	buf[i+1] = '\0';
}

Unless I am missing something :)
>  
> -	memcpy(&buffer[i], vpd->vpids.product_id, IPR_PROD_ID_LEN);
> -	i = strip_and_pad_whitespace(i + IPR_PROD_ID_LEN - 1, buffer);
> +	memcpy(product_id, vpd->vpids.product_id, IPR_PROD_ID_LEN);
> +	strip_whitespace(IPR_PROD_ID_LEN, product_id);
>  
> -	memcpy(&buffer[i], vpd->sn, IPR_SERIAL_NUM_LEN);
> -	buffer[IPR_SERIAL_NUM_LEN + i] = '\0';
> +	memcpy(sn, vpd->sn, IPR_SERIAL_NUM_LEN);
> +	strip_whitespace(IPR_SERIAL_NUM_LEN, sn);
>  
> -	ipr_hcam_err(hostrcb, "%s VPID/SN: %s\n", prefix, buffer);
> +	ipr_hcam_err(hostrcb, "%s VPID/SN: %s %s %s\n", prefix,
> +		     vendor_id, product_id, sn);
>  }
>  
>  /**

-- 
Damien Le Moal
Western Digital Research

